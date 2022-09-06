import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/profile/widgets/bookmarked_tile.dart';

import '../../i18n/locale_constant.dart';
import '../../util/constants.dart';
import '../../util/graphl_ql_queries.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  String languageCode = "";
  String userId = "";
  bool itemRemoved = false;
  Map<String, String> bookmarkedItems = {};

  @override
  void initState() {
    super.initState();
    _getLanguageCodeAndUser();
  }

  void _getLanguageCodeAndUser() async {
    Locale locale = await getLocale();
    ParseUser current = await ParseUser.currentUser();
    setState(() {
      languageCode = locale.languageCode;
      userId = current.objectId!;
    });
  }

  void _removeBookmark(String objectId, bool isItem) async {
    // remove from database
    GraphQLClient client = GraphQLProvider.of(context).value;
    bool success = false;
    if (isItem) {
      success = await GraphQLQueries.removeItemBookmark(objectId, client);
    } else {
      //TODO: remove bookmark for tip
    }

    //remove from display list
    if (success) {
      setState(() {
        bookmarkedItems.remove(objectId);
        itemRemoved = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Languages.of(context)!.bookmarkingFailedText),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.bookmarkPageTitle),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(GraphQLQueries.bookmarkedItemsQuery),
          variables: {
            "languageCode": languageCode,
            "userId": userId,
          },
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) return Text(result.exception.toString());
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // get municipalities for selection
          if (bookmarkedItems.isEmpty && !itemRemoved) {
            List<dynamic> bookmarkedItemData =
                result.data?["getAllItemBookmarksForUser"];
            for (dynamic element in bookmarkedItemData) {
              bookmarkedItems[element["item_id"]["objectId"]] =
                  element["title"];
            }
          }

          // display when all data is available
          return Padding(
            padding: EdgeInsets.all(Constants.pagePadding),
            child: bookmarkedItems.isEmpty
                ? Center(
                    child:
                        Text(Languages.of(context)!.noBookmarksAvailableText),
                  )
                : ListView(
                    children: [
                      ...bookmarkedItems.entries.map((element) {
                        return BookmarkedTile(
                          title: element.value,
                          objectId: element.key,
                          isItem: true,
                          removeBookmark: _removeBookmark,
                        );
                      }),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
