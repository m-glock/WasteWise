import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/logic/database_access/queries/dashboard_queries.dart';
import 'package:recycling_app/logic/database_access/queries/item_queries.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/tip_detail_page.dart';
import 'package:recycling_app/logic/util/constants.dart';

import '../util/user.dart';
import '../../model_classes/item.dart';
import '../../model_classes/tip.dart';
import '../../presentation/pages/search/search_sort_page.dart';
import '../database_access/graphl_ql_queries.dart';
import '../util/notification_type.dart';
import 'data_service.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  NotificationDetails? _notificationDetails;
  BuildContext? context;

  Future<void> init(
      Function(NotificationResponse) notificationTapBackground,
      BuildContext context,
  ) async {
    // initialize plugin
    this.context = context;

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('assets/icons/logo.png');
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

  void startSchedule() async {
    int weekday = DateTime.now().weekday;
    if (weekday == 1) {
      // new tip
      startScheduledNotification(NotificationType.tip.index);
    } else if (weekday == 3) {
      // new item
      startScheduledNotification(NotificationType.item.index);
    } else if (weekday == 5 &&
        Provider.of<User>(context!, listen: false).currentUser != null) {
      // wrongly sorted item, only start this scheduled notification if user is
      // logged in, otherwise there is no search history available
      startScheduledNotification(NotificationType.wronglySorted.index);
    }
  }

  void startWronglySortedNotification(){
    startScheduledNotification(NotificationType.wronglySorted.index);
  }

  void stopWronglySortedNotification() {
    if (_flutterLocalNotificationsPlugin == null) return;
    _flutterLocalNotificationsPlugin!.cancel(NotificationType.wronglySorted.index);
  }

  void stopSchedule() {
    if (_flutterLocalNotificationsPlugin == null) return;
    _flutterLocalNotificationsPlugin!.cancelAll();
  }

  void startScheduledNotification(int id) async {
    if (_flutterLocalNotificationsPlugin == null ||
        _notificationDetails == null) {
      return;
    }
    String title;
    String body;
    switch (id) {
      case 1:
        title = Languages.of(context!)!.notificationItemTitle;
        body = Languages.of(context!)!.notificationItemBody;
        break;
      case 2:
        title = Languages.of(context!)!.notificationSortTitle;
        body = Languages.of(context!)!.notificationSortBody;
        break;
      default:
        title = Languages.of(context!)!.notificationTipTitle;
        body = Languages.of(context!)!.notificationTipBody;
        break;
    }
    await _flutterLocalNotificationsPlugin!.periodicallyShow(
        id, title, body, RepeatInterval.everyMinute, _notificationDetails!, //TODO change that for final commit
        androidAllowWhileIdle: true);
  }

  void openTipPage() async {
    Tip tip = await DashboardQueries.getRandomTip(context!);
    Navigator.push(
        context!,
        MaterialPageRoute(
            builder: (context) =>
                TipDetailPage(tip: tip, updateBookmarkInParent: () => {})));
  }

  void openSortScreen(bool wronglySorted) async {
    QueryResult<Object?> result;
    String userId =
        Provider.of<User>(context!, listen: false).currentUser?.objectId ?? "";
    String itemId;
    if (wronglySorted) {
      // get recently wrongly sorted item
      GraphQLClient client = GraphQLProvider.of(context!).value;
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
      DataService dataService = Provider.of<DataService>(context!, listen: false);
      int index = rand.nextInt(dataService.itemNames.length);
      MapEntry<String, String> itemData =
          dataService.itemNames.entries.elementAt(index);
      itemId = itemData.value;
    }

    Item item = await ItemQueries.getItemDetails(context!, itemId, userId);
    Navigator.push(context!,
        MaterialPageRoute(builder: (context) => SearchSortPage(item: item)));
  }
}
