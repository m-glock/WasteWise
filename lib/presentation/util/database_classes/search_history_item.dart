import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';

import '../data_holder.dart';
import '../graphl_ql_queries.dart';

class SearchHistoryItem {
  final String objectId;
  final String title;
  final WasteBinCategory correctWasteBin;
  final WasteBinCategory selectedCategory;
  final DateTime createdAt;

  SearchHistoryItem(this.objectId, this.title, this.correctWasteBin,
      this.selectedCategory, this.createdAt);

  static Future<SearchHistoryItem> fromJson(dynamic searchHistoryData,
      GraphQLClient client, String languageCode) async {
    WasteBinCategory correctCategory = DataHolder.categoriesById[
        searchHistoryData["item_id"]["subcategory_id"]["category_id"]
            ["objectId"]]!;

    QueryResult<Object> result = await client.query(
      QueryOptions(
        document: gql(GraphQLQueries.getItemName),
        variables: {
          "languageCode": languageCode,
          "itemId": searchHistoryData["item_id"]["objectId"],
        },
      ),
    );

    DateTime temp = DateTime.parse(searchHistoryData["createdAt"]);
    return SearchHistoryItem(
        searchHistoryData["item_id"]["objectId"],
        result.data?["getItemName"]["title"],
        correctCategory,
        DataHolder
            .categoriesById[searchHistoryData["selected_category_id"]["objectId"]]!,
        temp);
  }
}
