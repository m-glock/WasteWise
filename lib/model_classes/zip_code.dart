import 'package:latlong2/latlong.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/zip_code.g.dart';

@JsonSerializable()
class ZipCode{

  final String objectId;
  final String municipalityId;
  final String zipCode;
  final LatLng latLng;

  ZipCode(this.objectId, this.municipalityId, this.zipCode, this.latLng);

  static ZipCode fromGraphQLData(dynamic data){
    return ZipCode(
        data["objectId"], 
        data["municipality_id"]["objectId"],
        data["zip_code"], 
        LatLng(data["lat_lng"]["latitude"], data["lat_lng"]["longitude"])
    );
  }

  factory ZipCode.fromJson(Map<String, dynamic> json) => _$ZipCodeFromJson(json);

  Map<String, dynamic> toJson() => _$ZipCodeToJson(this);

  int compareTo(ZipCode other) {
    return zipCode.compareTo(other.zipCode);
  }

  @override
  String toString() {
    return zipCode;
  }
}