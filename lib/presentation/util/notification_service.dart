import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/tip_detail_page.dart';
import 'package:recycling_app/presentation/util/constants.dart';

import '../i18n/locale_constant.dart';
import '../pages/search/search_sort_page.dart';
import 'data_holder.dart';
import 'database_classes/item.dart';
import 'database_classes/tip.dart';
import 'database_classes/user.dart';
import 'graphl_ql_queries.dart';
import 'notification_type.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  NotificationDetails? _notificationDetails;

  Future<void> init(
      Function(NotificationResponse) notificationTapBackground) async {
    // initialize plugin
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon'); //TODO get app icon
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: null,
            macOS: null,
            linux: null);
    await _flutterLocalNotificationsPlugin!.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationTapBackground,
    );

    // create notification
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(Constants.channelId, Constants.channelName,
            channelDescription: Constants.channelDescription);
    _notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
  }

  void startSchedule(BuildContext context) async {
    int weekday = DateTime.now().weekday;
    if (weekday == 1) {
      // new tip
      startScheduledNotification(NotificationType.tip.index, context);
    } else if (weekday == 3) {
      // new item
      startScheduledNotification(NotificationType.item.index, context);
    } else if (weekday == 5 &&
        Provider.of<User>(context, listen: false).currentUser != null) {
      // wrongly sorted item, only start this scheduled notification if user is
      // logged in, otherwise there is no search history available
      startScheduledNotification(NotificationType.wronglySorted.index, context);
    }
  }

  void startWronglySortedNotification(BuildContext context){
    startScheduledNotification(NotificationType.wronglySorted.index, context);
  }

  void stopWronglySortedNotification() {
    if (_flutterLocalNotificationsPlugin == null) return;
    _flutterLocalNotificationsPlugin!.cancel(NotificationType.wronglySorted.index);
  }

  void stopSchedule() {
    if (_flutterLocalNotificationsPlugin == null) return;
    _flutterLocalNotificationsPlugin!.cancelAll();
  }

  void startScheduledNotification(int id, BuildContext context) async {
    if (_flutterLocalNotificationsPlugin == null ||
        _notificationDetails == null) {
      return;
    }
    String title;
    String body;
    switch (id) {
      case 1:
        title = Languages.of(context)!.notificationItemTitle;
        body = Languages.of(context)!.notificationItemBody;
        break;
      case 2:
        title = Languages.of(context)!.notificationSortTitle;
        body = Languages.of(context)!.notificationSortBody;
        break;
      default:
        title = Languages.of(context)!.notificationTipTitle;
        body = Languages.of(context)!.notificationTipBody;
        break;
    }
    await _flutterLocalNotificationsPlugin!.periodicallyShow(
        id, title, body, RepeatInterval.everyMinute, _notificationDetails!,
        androidAllowWhileIdle: true);
  }

  void openTipPage(BuildContext context) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GraphQLQueries.getRandomTip),
        variables: {"languageCode": (await getLocale()).languageCode},
      ),
    );

    Tip tip = Tip.fromGraphQlData(result.data?["getRandomTip"]);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TipDetailPage(tip: tip, updateBookmarkInParent: () => {})));
  }

  void openSortScreen(BuildContext context, bool wronglySorted) async {
    QueryResult<Object?> result;
    String userId =
        Provider.of<User>(context, listen: false).currentUser?.objectId ?? "";
    String itemId;
    if (wronglySorted) {
      // get recently wrongly sorted item
      GraphQLClient client = GraphQLProvider.of(context).value;
      result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.networkOnly,
          document: gql(GraphQLQueries.getRecentlyWronglySortedItem),
          variables: {"userId": userId},
        ),
      );
      itemId = result.data?["getRecentlyWronglySortedItem"];
    } else {
      // get random item
      Random rand = Random();
      int index = rand.nextInt(DataHolder.itemNames.length);
      MapEntry<String, String> itemData =
          DataHolder.itemNames.entries.elementAt(index);
      itemId = itemData.value;
    }

    Map<String, dynamic> inputVariables = {
      "languageCode": (await getLocale()).languageCode,
      "itemObjectId": itemId,
      "userId": userId,
    };
    GraphQLClient client = GraphQLProvider.of(context).value;
    result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(GraphQLQueries.itemDetailQuery),
        variables: inputVariables,
      ),
    );

    Item item = Item.fromGraphQlData(result.data)!;

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SearchSortPage(item: item)));
  }
}
