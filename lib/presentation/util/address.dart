import 'package:latlong2/latlong.dart';

class Address{

  final String street;
  final String number;
  final String zipCode;
  final String district;
  final LatLng location;

  Address(this.street, this.number, this.zipCode, this.district, this.location);
}