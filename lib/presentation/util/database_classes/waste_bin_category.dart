import 'cycle.dart';
import 'myth.dart';

class WasteBinCategory{
  final String title;
  final String objectId;
  final String pictogramUrl;
  final List<Myth> myths = [];
  final List<String> itemsBelong = [];
  final List<String> itemsDontBelong = [];
  final List<Cycle> cycleSteps = [];

  WasteBinCategory(this.title, this.objectId, this.pictogramUrl);

  static WasteBinCategory fromJson(dynamic category){
    return WasteBinCategory(
        category["title"],
        category["category_id"]["objectId"],
        category["category_id"]["image_file"]["url"]
    );
  }

  @override
  bool operator == (Object other){
    return other is WasteBinCategory && objectId == other.objectId;
  }

  @override
  int get hashCode => objectId.hashCode;

}
