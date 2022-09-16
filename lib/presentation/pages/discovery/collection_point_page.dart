import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/collection_point/comrade_dialog_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/collection_point/map_filter_dropdown_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/collection_point/map_widget.dart';

import 'package:recycling_app/presentation/util/data_holder.dart';
import 'package:latlong2/latlong.dart';

import '../../util/database_classes/collection_point.dart';

class CollectionPointPage extends StatefulWidget {
  const CollectionPointPage({Key? key}) : super(key: key);

  @override
  State<CollectionPointPage> createState() => _CollectionPointPageState();
}

class _CollectionPointPageState extends State<CollectionPointPage> {
  LatLng currentPosition = LatLng(52.5200, 13.4050);
  Map<CollectionPoint, Marker> filteredMarkers = {};
  String? chosenSubcategoryTitle;

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _getValues();
  }

  void _getValues(){
    filteredMarkers = Map.of(DataHolder.markers);
  }

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void _filterMarkers(String subcategoryTitle) {
    filteredMarkers.clear();
    filteredMarkers.addAll(DataHolder.markers);
    if(subcategoryTitle != Languages.of(context)!.cpDropdownDefault){
      filteredMarkers.removeWhere(
              (key, value) => !key.containsSubcategoryTitle(subcategoryTitle));
    }
    setState(() {
      chosenSubcategoryTitle = subcategoryTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropdownValues = DataHolder.cpSubcategories.toList();
    dropdownValues.insert(0, Languages.of(context)!.cpDropdownDefault);
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.collectionPointsTitle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: MapFilterDropdownWidget(
              dropdownValues: dropdownValues,
              updateMarkersInParent: _filterMarkers,
            ),
          ),
          Flexible(
            child: MapWidget(
              marker: filteredMarkers,
              currentPosition: currentPosition,
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            child: const Icon(Icons.group),
            onPressed: () => ComradeDialogWidget.showModal(
                context, chosenSubcategoryTitle ?? ""),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          FloatingActionButton(
            heroTag: 'btn2',
            child: const Icon(FontAwesomeIcons.filter),
            onPressed: () => {
              //TODO: implement filter
            },
          ),
        ],
      ),
    );
  }
}
