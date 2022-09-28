import 'package:recycling_app/presentation/util/data_holder.dart';
import 'package:recycling_app/presentation/util/database_classes/tip.dart';
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';

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

  static Item? fromGraphQlData(Map<dynamic, dynamic>? data) {
    if(data == null) return null;

    Map<dynamic, dynamic> item = data["getItem"];
    List<dynamic> itemTips = data["getTipsOfItem"];
    Map<dynamic, dynamic> subcategoryData = data["getSubcategoryOfItem"];

    String objectId = item["item_id"]["objectId"];
    String categoryId =
        item["item_id"]["subcategory_id"]["category_id"]["objectId"];
    String explanation =
        item["explanation"] != null && item["explanation"] != ""
            ? item["explanation"]
            : subcategoryData["explanation"];
    String subcategoryTitle = subcategoryData["title"];
    bool isBookmarked = data["getBookmarkStatusOfItem"] != null;

    Item newItem = Item(objectId, item["title"],
        DataHolder.categoriesById[categoryId]!,
        synonyms: item["synonyms"],
        explanation: explanation,
        subcategory: subcategoryTitle,
        bookmarked: isBookmarked);

    List<dynamic> tipTypeData = data["getTipTypes"];
    Map<String, String> tipTypeById = {};
    for (dynamic tipType in tipTypeData) {
      tipTypeById[tipType["tip_type_id"]["default_label"]] =
          tipType["tip_type_id"]["objectId"];
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
