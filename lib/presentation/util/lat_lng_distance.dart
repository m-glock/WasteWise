import 'dart:math';

import 'package:latlong2/latlong.dart';
import 'package:recycling_app/presentation/util/database_classes/zip_code.dart';

double _calculateDistance(LatLng one, LatLng two){
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 - c((two.latitude - one.latitude) * p)/2 +
      c(one.latitude * p) * c(two.latitude * p) *
          (1 - c((two.longitude - one.longitude) * p))/2;

  double temp = 12742 * asin(sqrt(a));
  return temp;
}

List<ZipCode> getNearbyZipCodes(List<ZipCode> latLngList, LatLng center){
  return latLngList.where((element) => _calculateDistance(center, element.latLng) < 5).toList();
}