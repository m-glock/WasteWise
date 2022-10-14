import 'package:recycling_app/model_classes/tip.dart';
import 'package:recycling_app/model_classes/waste_bin_category.dart';

import '../logic/services/data_service.dart';

class Item {
  final String objectId;
  final String title;
  final String? synonyms;
  final String? explanation;
  final String? subcategory;
  final WasteBinCategory wasteBin;
  final List<Tip> tips = [];
  final List<Tip> preventions = [];
  bool bookmarked;

  Item(this.objectId, this.title, this.wasteBin,
      {this.synonyms, this.explanation, this.subcategory,
        this.bookmarked = false});

  static Item? fromGraphQlData(Map<dynamic, dynamic>? data, DataService dataService) {
    if(data == null) return null;

    Map<dynamic, dynamic> item = data["itemTLS"];
    List<dynamic> itemTips = data["getTipsOfItem"];
    Map<dynamic, dynamic> subcategoryData = data["getSubcategoryOfItem"];

    String objectId = item["edges"][0]["node"]["item_id"]["objectId"];
    String categoryId =
    item["edges"][0]["node"]["item_id"]["subcategory_id"]["category_id"]["objectId"];
    String explanation =
    item["edges"][0]["node"]["explanation"] != null && item["edges"][0]["node"]["explanation"] != ""
            ? item["edges"][0]["node"]["explanation"]
            : subcategoryData["explanation"];
    String subcategoryTitle = subcategoryData["title"];
    bool isBookmarked = data["getBookmarkStatusOfItem"] != null;

    Item newItem = Item(objectId, item["edges"][0]["node"]["title"],
        dataService.categoriesById[categoryId]!,
        synonyms: item["edges"][0]["node"]["synonyms"],
        explanation: explanation,
        subcategory: subcategoryTitle,
        bookmarked: isBookmarked);

    List<dynamic> tipTypeData = data["tipTypes"]["edges"];
    Map<String, String> tipTypeById = {};
    for (dynamic tipType in tipTypeData) {
      tipTypeById[tipType["node"]["default_label"]] =
          tipType["node"]["objectId"];
    }

    for (dynamic tip in itemTips) {
      Tip newTip = Tip.fromGraphQlData(tip);
      if(newTip.tipTypeId == tipTypeById["Prevention"]){
        newItem.preventions.add(newTip);
      } else if(newTip.tipTypeId == tipTypeById["Separation"]){
        newItem.tips.add(newTip);
      }

    }

    return newItem;
  }
}
