import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/pages/search/widgets/search_sort_grid_tile.dart';
import 'package:recycling_app/presentation/util/constants.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';

import '../../i18n/languages.dart';
import '../../i18n/locale_constant.dart';
import '../../util/database_classes/item.dart';
import '../../util/graphl_ql_queries.dart';

class SearchSortPage extends StatefulWidget {
  const SearchSortPage(
      {Key? key, required this.itemObjectId, required this.title})
      : super(key: key);

  final String itemObjectId;
  final String title;

  @override
  State<SearchSortPage> createState() => _SearchSortPageState();
}

class _SearchSortPageState extends State<SearchSortPage> {
  String languageCode = "";
  String userId = "";

  @override
  void initState() {
    super.initState();
    _getLanguageCodeAndUserId();
  }

  void _getLanguageCodeAndUserId() async {
    Locale locale = await getLocale();
    ParseUser? current = await ParseUser.currentUser();
    setState(() {
      languageCode = locale.languageCode;
      userId = current?.objectId ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Query(
        options: QueryOptions(
            //TODO: check if still necessary after figuring cache out
            fetchPolicy: FetchPolicy.networkOnly,
            document: gql(GraphQLQueries.itemDetailQuery),
            variables: {
              "languageCode": languageCode,
              "itemObjectId": widget.itemObjectId,
              "userId": userId,
            }),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) return Text(result.exception.toString());
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          Map<String, dynamic> itemData = result.data?["getItem"];
          Map<String, dynamic> subcategory =
              result.data?["getSubcategoryOfItem"];
          bool bookmarkedStatus =
              result.data?["getBookmarkStatusOfItem"] != null;

          if (itemData.isEmpty) {
            Navigator.pop(context);
            //TODO: let user know whats wrong
            return const Text("No item found.");
          }

          Item item = Item.fromJson(itemData, subcategory, bookmarkedStatus);

          // display when all data is available
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Constants.pagePadding),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      Languages.of(context)!.searchSortQuestion,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: <Widget>[
                      ...DataHolder.categories.values.map((category) {
                        return SearchSortGridTile(
                          category: category,
                          isCorrect:
                              category.objectId == item.wasteBin.objectId,
                          item: item,
                        );
                      }).toList(),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
