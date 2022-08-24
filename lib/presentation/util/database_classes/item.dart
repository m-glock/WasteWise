import 'package:recycling_app/presentation/util/data_holder.dart';
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';

class Item {
  final String title;
  final String explanation;
  final String material;
  final String subcategory;
  final WasteBinCategory wasteBin;
  final bool bookmarked;
  //TODO: get tips and preventions

  Item(this.title, this.explanation, this.material, this.subcategory,
      this.wasteBin, this.bookmarked);

  static Item fromJson(Map<dynamic, dynamic> item, Map<dynamic, dynamic> subcategoryData){
    String categoryId = item["item_id"]["subcategory_id"]["category_id"]["objectId"];
    String explanation = item["explanation"] != null && item["explanation"] != ""
        ? item["explanation"]
        : subcategoryData["explanation"];
    String subcategoryTitle = subcategoryData["title"];
    //TODO figure out how to get bookmarked information
    bool isBookmarked = false;

    return Item(
        item["title"],
        explanation,
        item["material"],
        subcategoryTitle,
        DataHolder.categories.firstWhere((category) => category.objectId == categoryId),
        isBookmarked
    );
  }
}
