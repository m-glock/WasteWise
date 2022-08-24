import 'address.dart';
import 'collection_point_type.dart';
import 'contact.dart';
import 'package:latlong2/latlong.dart';

class CollectionPoint {
  late String objectId;
  late String link;
  late String openingHours;
  late Contact contact;
  late Address address;
  late CollectionPointType collectionPointType;

  CollectionPoint(
      dynamic collectionPointData, dynamic collectionPointTypeData) {
    dynamic collectionPointType = collectionPointTypeData.firstWhere((cpType) =>
        cpType["collection_point_type_id"]["objectId"] ==
        collectionPointData["collection_point_type_id"]["objectId"]);

    CollectionPointType cpType = CollectionPointType(
      collectionPointData["collection_point_type_id"]["objectId"],
      collectionPointType["title"],
    );
    Address address = Address(
        collectionPointData["address_id"]["street"],
        collectionPointData["address_id"]["number"],
        collectionPointData["address_id"]["zip_code"],
        collectionPointData["address_id"]["district"],
        LatLng(collectionPointData["address_id"]["location"]["latitude"],
            collectionPointData["address_id"]["location"]["longitude"]));
    Contact contact = Contact(
        collectionPointData["contact_id"]["phone"],
        collectionPointData["contact_id"]["fax"],
        collectionPointData["contact_id"]["email"]);

    objectId = collectionPointData["objectId"];
    link = collectionPointData["link"];
    openingHours = collectionPointData["opening_hours"];
    this.contact = contact;
    this.address = address;
    this.collectionPointType = cpType;
  }
}
