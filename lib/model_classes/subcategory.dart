import 'package:json_annotation/json_annotation.dart';

part 'generated/subcategory.g.dart';

@JsonSerializable()
class Subcategory {
  final String title;
  final String objectId;
  final String parentId;

  Subcategory(this.title, this.objectId, this.parentId);

  static Subcategory fromGraphQlData(Map<dynamic, dynamic> subcategory){
    return Subcategory(
        subcategory["title"],
        subcategory["subcategory_id"]["objectId"],
        subcategory["subcategory_id"]["category_id"]["objectId"]);
  }

  factory Subcategory.fromJson(Map<String, dynamic> json) => _$SubcategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryToJson(this);
}
