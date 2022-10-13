import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../model_classes/zip_code.dart';

double _calculateDistance(LatLng one, LatLng two){
  return Geolocator.distanceBetween(one.latitude, one.longitude, two.latitude, two.longitude) / 1000;
}

List<ZipCode> getNearbyZipCodes(List<ZipCode> latLngList, LatLng center){
  return latLngList.where((element) => _calculateDistance(center, element.latLng) < 3).toList();
}