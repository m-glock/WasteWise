import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/logic/database_access/queries/item_queries.dart';
import 'package:recycling_app/logic/services/data_service.dart';
import 'package:recycling_app/model_classes/waste_bin_category.dart';

class SearchHistoryItem {
  final String objectId;
  final String title;
  final WasteBinCategory correctWasteBin;
  final WasteBinCategory selectedCategory;
  final DateTime createdAt;

  SearchHistoryItem(this.objectId, this.title, this.correctWasteBin,
      this.selectedCategory, this.createdAt);

  static Future<SearchHistoryItem> fromGraphQlData(dynamic searchHistoryData,
      GraphQLClient client, String languageCode, DataService dataService, BuildContext context) async {
    WasteBinCategory correctCategory = dataService.categoriesById[
        searchHistoryData["item_id"]["subcategory_id"]["category_id"]
            ["objectId"]]!;

    String itemName = await ItemQueries.getItemName(
        context, languageCode, searchHistoryData["item_id"]["objectId"]);

    DateTime temp = DateTime.parse(searchHistoryData["createdAt"]);
    return SearchHistoryItem(
        searchHistoryData["item_id"]["objectId"],
        itemName,
        correctCategory,
        dataService
            .categoriesById[searchHistoryData["selected_category_id"]["objectId"]]!,
        temp);
  }
}
