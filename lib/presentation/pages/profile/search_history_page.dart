import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/profile/widgets/history_tile.dart';
import 'package:recycling_app/presentation/util/database_classes/search_history_item.dart';

import '../../i18n/locale_constant.dart';
import '../../util/constants.dart';
import '../../util/graphl_ql_queries.dart';

class SearchHistoryPage extends StatefulWidget {
  const SearchHistoryPage({Key? key}) : super(key: key);

  @override
  State<SearchHistoryPage> createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  String languageCode = "";
  List<SearchHistoryItem> itemsAndCategories = [];

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

  void _getItems(List<dynamic> searchHistoryData) async {
    List<SearchHistoryItem> items = [];
    GraphQLClient client = GraphQLProvider.of(context).value;
    for (dynamic element in searchHistoryData) {
      items
          .add(await SearchHistoryItem.fromGraphQlData(element, client, languageCode));
    }

    setState(() {
      itemsAndCategories = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.searchHistoryPageTitle),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(GraphQLQueries.searchHistoryQuery),
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
          List<dynamic> searchHistoryData = result.data?["getSearchHistory"];
          _getItems(searchHistoryData);

          // display when all data is available
          return Padding(
            padding: EdgeInsets.all(Constants.pagePadding),
            child: ListView(
              children: [
                ...itemsAndCategories.map((element) {
                  return HistoryTile(item: element);
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
