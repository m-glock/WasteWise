import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../util/database_classes/collection_point.dart';
import 'custom_marker.dart';

class MapWidget extends StatefulWidget {
  const MapWidget(
      {Key? key, required this.marker, required this.currentPosition})
      : super(key: key);

  final Map<Marker, CollectionPoint?> marker;
  final LatLng currentPosition;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  List<Marker> markerList = [];

  @override
  void initState() {
    super.initState();
    markerList.addAll(widget.marker.keys);
    markerList.add(Marker(
      anchorPos: AnchorPos.align(AnchorAlign.top),
      width: 220,
      height: 200,
      point: widget.currentPosition,
      builder: (ctx) => const CustomMarkerWidget(
          collectionPoint: null, markerColor: Colors.redAccent),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: widget.currentPosition,
        zoom: 13,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
          userAgentPackageName: 'com.glock.recyclingapp',
        ),
        MarkerLayerOptions(markers: markerList),
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
