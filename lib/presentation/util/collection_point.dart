import 'address.dart';
import 'collection_point_type.dart';
import 'contact.dart';

class CollectionPoint{
  final String objectId;
  final String link;
  final String openingHours;
  final Contact contact;
  final Address address;
  final CollectionPointType collectionPointType;

  CollectionPoint(this.objectId, this.link, this.openingHours, this.contact, this.address,
      this.collectionPointType);
}
