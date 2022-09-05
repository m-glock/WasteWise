import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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

  @override
  void initState() {
    super.initState();
    _getLanguageCode();
  }

  void _getLanguageCode() async {
    Locale locale = await getLocale();
    setState(() {
      languageCode = locale.languageCode;
    });
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
            "userId": "WLm921fNAG",
          },
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) return Text(result.exception.toString());
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // get municipalities for selection
          List<dynamic> bookmarkedItemData =
              result.data?["getAllItemBookmarksForUser"];
          Map<String, String> bookmarkedItems = {};
          for (dynamic element in bookmarkedItemData) {
            bookmarkedItems[element["item_id"]["objectId"]] = element["title"];
          }

          // display when all data is available
          return Padding(
            padding: EdgeInsets.all(Constants.pagePadding),
            child: ListView(
              children: [
                ...bookmarkedItems.entries.map((element) {
                  return BookmarkedTile(
                    title: element.value,
                    objectId: element.key,
                    isItem: true,
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
