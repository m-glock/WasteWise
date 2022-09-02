import 'package:recycling_app/presentation/util/data_holder.dart';
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';

class Item {
  final String objectId;
  final String title;
  final String? explanation;
  final String material;
  final String? subcategory;
  final WasteBinCategory wasteBin;
  bool bookmarked;

  //TODO: get tips and preventions

  Item(this.objectId, this.title, this.material,
       this.wasteBin, {this.explanation, this.subcategory, this.bookmarked = false});

  static Item fromJson(
      Map<dynamic, dynamic> item, Map<dynamic, dynamic> subcategoryData) {
    String objectId = item["item_id"]["objectId"];
    String categoryId =
        item["item_id"]["subcategory_id"]["category_id"]["objectId"];
    String explanation =
        item["explanation"] != null && item["explanation"] != ""
            ? item["explanation"]
            : subcategoryData["explanation"];
    String subcategoryTitle = subcategoryData["title"];
    //TODO figure out how to get bookmarked information
    bool isBookmarked = false;

    return Item(
        objectId,
        item["title"],
        item["material"],
        DataHolder.categories[categoryId]!,
        explanation: explanation,
        subcategory: subcategoryTitle,
        bookmarked: isBookmarked);
  }
}
