import 'package:latlong2/latlong.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/address.g.dart';

@JsonSerializable()
class Address{

  final String street;
  final String number;
  final String zipCode;
  final String district;
  final LatLng location;

  Address(this.street, this.number, this.zipCode, this.district, this.location);

  static Address fromGraphQlData(dynamic addressData){
    return Address(
        addressData["street"],
        addressData["number"],
        addressData["zip_code"],
        addressData["district"],
        LatLng(addressData["location"]["latitude"],
            addressData["location"]["longitude"]));
  }

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  String toString() {
    return "$street $number,\n $zipCode $district";
  }
}