import 'package:recycling_app/model_classes/subcategory.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../model_classes/address.dart';
import '../logic/data_holder.dart';
import '../../../model_classes/contact.dart';
import 'collection_point_type.dart';

part 'generated/collection_point.g.dart';

@JsonSerializable(explicitToJson: true)
class CollectionPoint {
  final String objectId;
  final String openingHours;
  final Contact contact;
  final Address address;
  final CollectionPointType collectionPointType;
  final bool withHazardousMaterials;
  final bool withSecondHand;
  final List<Subcategory> acceptedSubcategories;

  CollectionPoint(this.objectId, this.openingHours, this.contact,
      this.address, this.collectionPointType, this.withHazardousMaterials,
      this.withSecondHand, this.acceptedSubcategories);

  static CollectionPoint fromGraphQlData(dynamic collectionPointData) {
    String cpTypeId =
        collectionPointData["collection_point_type_id"]["objectId"];
    CollectionPointType cpType = DataHolder.collectionPointTypes
        .firstWhere((element) => element.objectId == cpTypeId);

    return CollectionPoint(
      collectionPointData["objectId"],
      collectionPointData["opening_hours"],
      Contact.fromGraphQlData(collectionPointData["contact_id"]),
      Address.fromGraphQlData(collectionPointData["address_id"]),
      cpType,
      collectionPointData["hazardous_materials"],
      collectionPointData["second_hand"],
      List.empty(growable: true),
    );
  }

  factory CollectionPoint.fromJson(Map<String, dynamic> json) => _$CollectionPointFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionPointToJson(this);

  bool containsSubcategoryTitle(String title){
    return acceptedSubcategories
        .where((subcategory) => subcategory.title == title)
        .isNotEmpty;
  }

  @override
  bool operator == (Object other){
    return other is CollectionPoint && objectId == other.objectId;
  }

  @override
  int get hashCode => objectId.hashCode;

}
