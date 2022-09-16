import 'package:json_annotation/json_annotation.dart';

part 'generated/collection_point_type.g.dart';

@JsonSerializable()
class CollectionPointType{

  final String objectId;
  final String title;

  CollectionPointType(this.objectId, this.title);

  static CollectionPointType fromGraphQLData(dynamic collectionPointData){
    return CollectionPointType(
      collectionPointData["collection_point_type_id"]["objectId"],
      collectionPointData["title"],
    );
  }

  factory CollectionPointType.fromJson(Map<String, dynamic> json) => _$CollectionPointTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionPointTypeToJson(this);
}