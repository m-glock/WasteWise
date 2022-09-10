import 'package:recycling_app/presentation/util/data_holder.dart';
import 'package:recycling_app/presentation/util/database_classes/tip.dart';
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';

class Item {
  final String objectId;
  final String title;
  final String? synonyms;
  final String? explanation;
  final String material;
  final String? subcategory;
  final WasteBinCategory wasteBin;
  final List<Tip> tips = [];
  bool bookmarked;

  Item(this.objectId, this.title, this.material, this.wasteBin,
      {this.synonyms, this.explanation, this.subcategory,
        this.bookmarked = false});

  static Item? fromJson(Map<dynamic, dynamic>? data) {
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

    Item newItem = Item(objectId, item["title"], item["material"],
        DataHolder.categories[categoryId]!,
        synonyms: item["synonyms"],
        explanation: explanation,
        subcategory: subcategoryTitle,
        bookmarked: isBookmarked);

    for (dynamic tip in itemTips) {
      newItem.tips.add(
          Tip.fromJson(tip));
    }

    return newItem;
  }
}
