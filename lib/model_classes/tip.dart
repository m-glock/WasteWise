import 'package:recycling_app/model_classes/subcategory.dart';

class Tip {
  final String objectId;
  final String title;
  final String explanation;
  final String short;
  final String tipTypeId;
  final List<Subcategory> subcategories = [];
  final String imageUrl;
  bool isBookmarked;

  Tip(this.objectId, this.title, this.explanation, this.tipTypeId,
      this.imageUrl, this.short,
      {this.isBookmarked = false});

  static Tip fromGraphQlData(Map<dynamic, dynamic> tip, {bool bookmarked = false}) {
    if(tip.containsKey("node")){
      return Tip(
          tip["node"]["tip_id"]["objectId"],
          tip["node"]["title"],
          tip["node"]["explanation"],
          tip["node"]["tip_id"]["tip_type_id"]["objectId"],
          tip["node"]["tip_id"]["image"]["url"],
          tip["node"]["short"],
          isBookmarked: bookmarked);
    } else {
      return Tip(
          tip["tip_id"]["objectId"],
          tip["title"],
          tip["explanation"],
          tip["tip_id"]["tip_type_id"]["objectId"],
          tip["tip_id"]["image"]["url"],
          tip["short"],
          isBookmarked: bookmarked);
    }
  }
}
