import 'package:json_annotation/json_annotation.dart';

import 'cycle.dart';
import 'myth.dart';

part 'generated/waste_bin_category.g.dart';

@JsonSerializable(explicitToJson: true)
class WasteBinCategory{
  final String title;
  final String objectId;
  final String pictogramUrl;
  final List<Myth> myths = [];
  final List<String> itemsBelong = [];
  final List<String> itemsDontBelong = [];
  final List<Cycle> cycleSteps = [];

  WasteBinCategory(this.title, this.objectId, this.pictogramUrl);

  static WasteBinCategory fromGraphQlData(dynamic category){
    return WasteBinCategory(
        category["title"],
        category["category_id"]["objectId"],
        category["category_id"]["image_file"]["url"]
    );
  }

  factory WasteBinCategory.fromJson(Map<String, dynamic> json) => _$WasteBinCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$WasteBinCategoryToJson(this);

  @override
  bool operator == (Object other){
    return other is WasteBinCategory && objectId == other.objectId;
  }

  @override
  int get hashCode => objectId.hashCode;

}
