import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/logic/database_access/queries/search_queries.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/search/widgets/history_tile.dart';

import '../../../logic/services/data_service.dart';
import '../../../model_classes/search_history_item.dart';
import '../../../logic/util/constants.dart';

class SearchHistoryPage extends StatefulWidget {
  const SearchHistoryPage(
      {Key? key, required this.userId, required this.languageCode})
      : super(key: key);

  final String userId;
  final String languageCode;

  @override
  State<SearchHistoryPage> createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  List<SearchHistoryItem> itemsAndCategories = [];

  void _getItems(List<dynamic> searchHistoryData) async {
    List<SearchHistoryItem> items = [];
    GraphQLClient client = GraphQLProvider.of(context).value;
    DataService dataService = Provider.of<DataService>(context, listen: false);
    for (dynamic element in searchHistoryData) {
      items.add(await SearchHistoryItem.fromGraphQlData(
          element, client, widget.languageCode, dataService, context));
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
          document: gql(SearchQueries.searchHistoryQuery),
          variables: {
            "userId": widget.userId,
          },
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) return Text(result.exception.toString());
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // get municipalities for selection
          List<dynamic> searchHistoryData =
              result.data?["searchHistories"]["edges"];
          _getItems(searchHistoryData);

          // display when all data is available
          return itemsAndCategories.isEmpty
              ? Center(
                  child: Text(Languages.of(context)!.searchHistoryEmpty),
                )
              : Padding(
                  padding: EdgeInsets.all(Constants.pagePadding),
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: itemsAndCategories.length,
                      itemBuilder: (BuildContext context, int index) {
                        SearchHistoryItem element = itemsAndCategories[index];
                        return HistoryTile(
                          item: element,
                          languageCode: widget.languageCode,
                          userId: widget.userId,
                        );
                      },
                    ),
                  ),
                );
        },
      ),
    );
  }
}
