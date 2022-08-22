import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../util/collection_point.dart';

class MapWidget extends StatefulWidget {
  const MapWidget(
      {Key? key, required this.defaultLocation, required this.marker})
      : super(key: key);

  final LatLng defaultLocation;
  final Map<Marker, CollectionPoint> marker;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: widget.defaultLocation,
        zoom: 13,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
          userAgentPackageName: 'com.glock.recyclingapp',
        ),
        MarkerLayerOptions(markers: widget.marker.keys.toList()),
      ],
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: null,
        ),
      ],
    );
  }
}
