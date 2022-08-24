import '../data_holder.dart';
import 'address.dart';
import 'collection_point_type.dart';
import 'contact.dart';

class CollectionPoint {
  late String objectId;
  late String link;
  late String openingHours;
  late Contact contact;
  late Address address;
  late CollectionPointType collectionPointType;

  CollectionPoint(this.objectId, this.link, this.openingHours, this.contact,
      this.address, this.collectionPointType);

  static CollectionPoint fromJson(dynamic collectionPointData) {
    String cpTypeId =
        collectionPointData["collection_point_type_id"]["objectId"];
    CollectionPointType cpType = DataHolder.collectionPointTypes
        .firstWhere((element) => element.objectId == cpTypeId);

    return CollectionPoint(
        collectionPointData["objectId"],
        collectionPointData["link"],
        collectionPointData["opening_hours"],
        Contact.fromJson(collectionPointData["contact_id"]),
        Address.fromJson(collectionPointData["address_id"]),
        cpType);
  }
}
