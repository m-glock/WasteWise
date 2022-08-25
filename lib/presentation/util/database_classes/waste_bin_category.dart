import 'dart:ui';
import '../hex_color.dart';
import 'cycle.dart';
import 'myth.dart';

class WasteBinCategory {
  final String title;
  final String objectId;
  final Color color;
  final String pictogramUrl;
  final List<Myth> myths = [];
  final List<String> itemsBelong = [];
  final List<String> itemsDontBelong = [];
  final List<Cycle> cycleSteps = [];

  WasteBinCategory(this.title, this.objectId, this.color, this.pictogramUrl);

  static WasteBinCategory fromJson(Map<dynamic, dynamic> category){
    return WasteBinCategory(
        category["title"],
        category["category_id"]["objectId"],
        HexColor.fromHex(category["category_id"]["hex_color"]),
        category["category_id"]["image_file"]["url"]);
  }
}
