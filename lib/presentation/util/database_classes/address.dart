import 'package:latlong2/latlong.dart';

class Address{

  final String street;
  final String number;
  final String zipCode;
  final String district;
  final LatLng location;

  Address(this.street, this.number, this.zipCode, this.district, this.location);

  static Address fromJson(dynamic addressData){
    return Address(
        addressData["street"],
        addressData["number"],
        addressData["zip_code"],
        addressData["district"],
        LatLng(addressData["location"]["latitude"],
            addressData["location"]["longitude"]));
  }

  @override
  String toString() {
    return "$street $number,\n $zipCode $district";
  }
}