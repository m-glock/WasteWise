import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/presentation/pages/search/widgets/barcode_scanner_button.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/pages/search/item_detail_page.dart';
import 'package:recycling_app/presentation/pages/search/search_sort_page.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';
import 'package:recycling_app/presentation/pages/search/widgets/search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../i18n/languages.dart';
import '../../i18n/locale_constant.dart';
import '../../util/constants.dart';
import '../../util/database_classes/item.dart';
import '../../util/database_classes/user.dart';
import '../../util/graphl_ql_queries.dart';
import 'search_history_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? languageCode;
  bool? learnMore;

  void _getVariables() async {
    Locale locale = await getLocale();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      languageCode = locale.languageCode;
      learnMore = _prefs.getBool(Constants.prefLearnMore) ?? true;
    });
  }

  List<Widget> _getItemList(Map<String, String> namesAndIds) {
    return namesAndIds.entries
        .map((entry) => InkWell(
              onTap: () {
                _getItem(entry.value).then((item) {
                  if (item == null) throw Exception("No item found.");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => learnMore ?? true
                              ? SearchSortPage(item: item)
                              : ItemDetailPage(item: item)));
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(entry.key,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ))
        .toList();
  }

  Future<Item?> _getItem(String itemId) async {
    // get item info
    Locale locale = await getLocale();
    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult result = await client.query(
      QueryOptions(document: gql(GraphQLQueries.itemDetailQuery), variables: {
        "languageCode": locale.languageCode,
        "itemObjectId": itemId,
        "userId":
            Provider.of<User>(context, listen: false).currentUser?.objectId ??
                "",
      }),
    );
    return Item.fromGraphQlData(result.data);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (BuildContext context, User user, child) {
      if(languageCode == null) _getVariables();
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(itemNames: DataHolder.itemNames),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BarcodeScannerButton(),
                    if (user.currentUser != null)
                      OutlinedButton(
                        child:
                            Text(Languages.of(context)!.searchHistoryPageTitle),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchHistoryPage(
                                    userId: user.currentUser!.objectId!,
                                    languageCode: languageCode!,
                                  )),
                        ),
                      ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 25)),
              languageCode == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Query(
                      options: QueryOptions(
                        document:
                            gql(GraphQLQueries.getRecentlyAndOftenSearched),
                        variables: {
                          "languageCode": languageCode,
                          "userId": user.currentUser?.objectId ?? "",
                        },
                      ),
                      builder: (QueryResult result,
                          {VoidCallback? refetch, FetchMore? fetchMore}) {
                        if (result.hasException) {
                          return Text(result.exception.toString());
                        }
                        if (result.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        // get recently searched items
                        List<dynamic> recentlySearchedData =
                            result.data?["recentlySearched"];
                        Map<String, String> recentlySearchedItems = {};
                        for (dynamic element in recentlySearchedData) {
                          recentlySearchedItems[element["title"]] =
                              element["item_id"]["objectId"];
                        }

                        // get often searched items
                        List<dynamic> oftenSearchedData =
                            result.data?["oftenSearched"];
                        Map<String, String> oftenSearched = {};
                        for (dynamic element in oftenSearchedData) {
                          oftenSearched[element["title"]] =
                              element["item_id"]["objectId"];
                        }

                        // display when all data is available
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (recentlySearchedItems.isNotEmpty) ...[
                              Text(Languages.of(context)!.recentlySearched,
                                  style: Theme.of(context).textTheme.headline3),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 15)),
                              ..._getItemList(recentlySearchedItems),
                            ],
                            const Padding(padding: EdgeInsets.only(bottom: 25)),
                            Text(Languages.of(context)!.oftenSearched,
                                style: Theme.of(context).textTheme.headline3),
                            const Padding(padding: EdgeInsets.only(bottom: 15)),
                            ..._getItemList(oftenSearched),
                          ],
                        );
                      },
                    ),
            ],
          ),
        ),
      );
    });
  }
}
