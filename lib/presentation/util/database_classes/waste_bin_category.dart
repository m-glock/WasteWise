import 'package:json_annotation/json_annotation.dart';

import 'cycle.dart';
import 'myth.dart';

part 'generated/waste_bin_category.g.dart';

@JsonSerializable(explicitToJson: true)
class WasteBinCategory{
  final String title;
  final String objectId;
  final List<Myth> myths;
  final List<String> itemsBelong;
  final List<String> itemsDontBelong;
  final List<Cycle> cycleSteps;
  final String imageFilePath;

  WasteBinCategory(this.title, this.objectId, this.myths,
      this.cycleSteps, this.itemsBelong, this.itemsDontBelong, this.imageFilePath);

  static WasteBinCategory fromGraphQlData(dynamic category, String imageFilePath) {
    return WasteBinCategory(
        category["title"],
        category["category_id"]["objectId"],
        List.empty(growable: true),
        List.empty(growable: true),
        List.empty(growable: true),
        List.empty(growable: true),
        imageFilePath
    );
  }

  factory WasteBinCategory.fromJson(Map<String, dynamic> json) =>
      _$WasteBinCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$WasteBinCategoryToJson(this);

  @override
  bool operator == (Object other){
    return other is WasteBinCategory && objectId == other.objectId;
  }

  @override
  int get hashCode => objectId.hashCode;

}
