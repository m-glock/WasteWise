import 'dart:ui';
import '../hex_color.dart';

class WasteBinCategory {
  final String title;
  final String objectId;
  final Color color;
  final String pictogramUrl;

  WasteBinCategory(this.title, this.objectId, this.color, this.pictogramUrl);

  static WasteBinCategory fromJson(Map<dynamic, dynamic> category){
    return WasteBinCategory(
        category["title"],
        category["category_id"]["objectId"],
        HexColor.fromHex(category["category_id"]["hex_color"]),
        category["category_id"]["image_file"]["url"]);
  }
}
