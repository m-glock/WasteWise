import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class CollectionPointPage extends StatefulWidget {
  const CollectionPointPage({Key? key}) : super(key: key);

  @override
  State<CollectionPointPage> createState() => _CollectionPointPageState();
}

class _CollectionPointPageState extends State<CollectionPointPage> {

  final markers = <Marker>[
    Marker(
      width: 80,
      height: 80,
      point: LatLng(51.5, -0.09),
      builder: (ctx) => const FlutterLogo(
        textColor: Colors.blue,
        key: ObjectKey(Colors.blue),
      ),
    ),
    Marker(
      width: 80,
      height: 80,
      point: LatLng(53.3498, -6.2603),
      builder: (ctx) => const FlutterLogo(
        textColor: Colors.green,
        key: ObjectKey(Colors.green),
      ),
    ),
    Marker(
      width: 80,
      height: 80,
      point: LatLng(48.8566, 2.3522),
      builder: (ctx) => const FlutterLogo(
        textColor: Colors.purple,
        key: ObjectKey(Colors.purple),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.collectionPointsTitle),
      ),
      body: FlutterMap(
          options: MapOptions(
            center: LatLng(51.509364, -0.128928),
            zoom: 9.2,
          ),
        layers: [
          TileLayerOptions(
            urlTemplate:
            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayerOptions(markers: markers)
        ],
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: () {},
          ),
        ],
    ),
    );
  }
}