import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class CollectionPointPage extends StatefulWidget {
  const CollectionPointPage({Key? key}) : super(key: key);

  @override
  State<CollectionPointPage> createState() => _CollectionPointPageState();
}

class _CollectionPointPageState extends State<CollectionPointPage> {

  //TODO ask user for current location
  final LatLng defaultLatLng = LatLng(52.5200, 13.4050);
  final List<Marker> markers = [
    Marker(
      width: 80,
      height: 80,
      point: LatLng(52.49959837860384, 13.48976890965241),
      builder: (ctx) => const Icon(Icons.location_on),
    ),
    Marker(
      width: 80,
      height: 80,
      point: LatLng(52.50774876167709, 13.352096497671688),
      builder: (ctx) => const Icon(Icons.location_on),
    ),
    Marker(
      width: 80,
      height: 80,
      point: LatLng(52.558497882764705, 13.402564931421479),
      builder: (ctx) => const Icon(Icons.location_on),
    ),
  ];

  final List<DropdownMenuItem<String>> dropdownOptions = const [
    DropdownMenuItem(child: Text("Elektronik")),
    DropdownMenuItem(child: Text("Altkleider")),
    DropdownMenuItem(child: Text("Dritte Option")),
  ];

  String dropdownValue = 'Elektronik';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.collectionPointsTitle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Elektronik', 'Altkleider', 'Dritte Option']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: FlutterMap(
              options: MapOptions(
                center: defaultLatLng,
                zoom: 9.2,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  userAgentPackageName: 'com.glock.recyclingapp',
                ),
                MarkerLayerOptions(markers: markers),
              ],
              nonRotatedChildren: [
                AttributionWidget.defaultWidget(
                  source: 'OpenStreetMap contributors',
                  onSourceTapped: null,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          FloatingActionButton(
            heroTag: 'btn1',
            child: Icon(Icons.group),
            onPressed: null,
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          FloatingActionButton(
            heroTag: 'btn2',
            child: Icon(FontAwesomeIcons.filter),
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
