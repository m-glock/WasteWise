import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';

import '../../../../util/database_classes/collection_point.dart';
import 'map_popup.dart';

class MapWidget extends StatefulWidget {
  const MapWidget(
      {Key? key, required this.marker, required this.currentPosition})
      : super(key: key);

  final Map<Marker, CollectionPoint> marker;
  final LatLng currentPosition;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  List<Marker> markerList = [];
  final PopupController _popupLayerController = PopupController();

  @override
  void initState() {
    super.initState();
    _setMarkers();
  }

  void _setMarkers(){
    if(markerList.isNotEmpty) markerList.clear();
    markerList.addAll(widget.marker.keys);
    markerList.add(Marker(
      width: 35,
      height: 35,
      point: widget.currentPosition,
      builder: (ctx) => const Icon(
        Icons.location_on,
        size: 35,
        color: Color.fromARGB(255, 220, 79, 37),
      ),
      anchorPos: AnchorPos.align(AnchorAlign.top),
    ));
  }

  @override
  void didUpdateWidget(covariant MapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: widget.currentPosition,
        zoom: 11,
        onTap: (_, __) => _popupLayerController.hideAllPopups(),
      ),
      children: [
        TileLayerWidget(
            options: TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              userAgentPackageName: 'com.glock.recyclingapp',
            ),
        ),
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
            popupController: _popupLayerController,
            markers: markerList,
            markerRotateAlignment:
              PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
            popupBuilder: (BuildContext context, Marker marker) =>
              MapPopup(marker, widget.marker[marker]!),
          ),
        ),
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
