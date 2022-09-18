import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/search/item_detail_page.dart';
import 'package:recycling_app/presentation/pages/search/search_sort_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../i18n/locale_constant.dart';
import '../../../util/constants.dart';
import '../../../util/database_classes/item.dart';
import '../../../util/graphl_ql_queries.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key, required this.itemNames}) : super(key: key);

  final Map<String, String> itemNames;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final GlobalKey<AutoCompleteTextFieldState<String>> _key = GlobalKey();

  void _getItemInfo(String selected) async {
    // check if user wants sort page or not
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool? learnMore = _prefs.getBool(Constants.prefLearnMore) ?? true;

    // get item info
    Locale locale = await getLocale();
    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult result = await client.query(
      QueryOptions(
          document: gql(GraphQLQueries.itemDetailQuery),
          variables: {
            "languageCode": locale.languageCode,
            "itemObjectId": widget.itemNames[selected],
            "userId": (await ParseUser.currentUser())?.objectId ?? "",
          }),
    );
    Item? item = Item.fromGraphQlData(result.data);
    if(item == null) throw Exception("No item found.");

    if(!learnMore){
      ParseUser? currentUser = await ParseUser.currentUser();
      if(currentUser != null){
        GraphQLClient client = GraphQLProvider.of(context).value;
        await client.query(
          QueryOptions(
            fetchPolicy: FetchPolicy.networkOnly,
            document: gql(GraphQLQueries.searchHistoryMutation),
            variables: {
              "itemId": item.objectId,
              "userId": currentUser.objectId,
              "selectedCategoryId": null,
              "sortedCorrectly": null
            },
          ),
        );
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => learnMore
              ? SearchSortPage(item: item)
              : ItemDetailPage(item: item)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                size: 20,
              ),
            ),
            Expanded(
              child: AutoCompleteTextField<String>(
                suggestions: widget.itemNames.keys.toList(),
                decoration: InputDecoration.collapsed(
                  hintText: Languages.of(context)!.searchBarHint,
                ),
                showCursor: false,
                itemSorter: (String item1, String item2) {
                  return item1.compareTo(item2);
                },
                itemBuilder: (BuildContext context, Object? suggestion) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(suggestion.toString()),
                  );
                },
                textSubmitted: (String data) {
                  if (widget.itemNames.containsKey(data)) {
                    _getItemInfo(data);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //TODO: Snackbar or modal?
                      content:
                          Text(Languages.of(context)!.searchBarItemNotExist),
                    ));
                  }
                },
                itemSubmitted: (String data) {
                  _getItemInfo(data);
                },
                key: _key,
                itemFilter: (String suggestion, String query) {
                  //TODO contains?
                  return suggestion
                      .toLowerCase()
                      .startsWith(query.toLowerCase());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
