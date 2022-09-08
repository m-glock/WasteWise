import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/pages/search/search_sort_page.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';
import 'package:recycling_app/presentation/pages/search/barcode_scan_page.dart';
import 'package:recycling_app/presentation/pages/search/widgets/search_bar.dart';

import '../../i18n/languages.dart';
import '../../i18n/locale_constant.dart';
import '../../util/graphl_ql_queries.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Map<String, String> oftenSearched = {
    "Korken": "www",
    "Kleiderbügel": "www",
    "Knochen": "www"
  };
  String? languageCode;
  String? userId;

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

  Widget _barcodeScannerButton() {
    return SizedBox(
      width: 160,
      child: ElevatedButton(
        child: Row(
          children: const [
            Icon(FontAwesomeIcons.barcode, size: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('Barcode Scanner'),
            )
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BarcodeScanPage()),
          );
        },
      ),
    );
  }

  List<Widget> _getItemList(Map<String, String> namesAndIds) {
    return namesAndIds.entries
        .map((entry) => InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchSortPage(
                      itemObjectId: entry.value,
                      title: entry.key,
                    )),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(entry.key,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(itemNames: DataHolder.itemNames),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 40),
              child: _barcodeScannerButton(),
            ),
            languageCode == null || userId == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Query(
                    options: QueryOptions(
                      document: gql(GraphQLQueries.getRecentlySearched),
                      variables: {
                        "languageCode": languageCode,
                        "userId": userId,
                      },
                    ),
                    builder: (QueryResult result,
                        {VoidCallback? refetch, FetchMore? fetchMore}) {
                      if (result.hasException) {
                        return Text(result.exception.toString());
                      }
                      if (result.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      // get municipalities for selection
                      List<dynamic> recentlySearchedData =
                          result.data?["recentlySearched"];
                      Map<String, String> recentlySearchedItems = {};
                      for (dynamic element in recentlySearchedData) {
                        recentlySearchedItems[element["title"]] =
                            element["item_id"]["objectId"];
                      }

                      // display when all data is available
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(recentlySearchedItems.isNotEmpty) ...[
                            Text(Languages.of(context)!.recentlySearched,
                                style: Theme.of(context).textTheme.headline3),
                            const Padding(padding: EdgeInsets.only(bottom: 15)),
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
  }
}
