import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/collection_point/comrade_dialog_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/collection_point/map_filter_dropdown_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/collection_point/map_widget.dart';

import 'package:latlong2/latlong.dart';

import '../../../logic/services/data_service.dart';
import '../../../model_classes/collection_point.dart';

class CollectionPointPage extends StatefulWidget {
  const CollectionPointPage({Key? key}) : super(key: key);

  @override
  State<CollectionPointPage> createState() => _CollectionPointPageState();
}

class _CollectionPointPageState extends State<CollectionPointPage> {
  LatLng currentPosition = LatLng(52.5200, 13.4050);
  Map<Marker, CollectionPoint> filteredMarkers = {};
  String? chosenSubcategoryTitle;
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _getValues();
    _checkIfLoggedIn();
  }

  void _getValues(){
    DataService dataService = Provider.of<DataService>(context, listen: false);
    filteredMarkers = Map.of(dataService.markers);
  }

  void _checkIfLoggedIn() async {
    ParseUser? current = await ParseUser.currentUser();
    setState(() {
      loggedIn = current != null;
    });
  }

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void _filterMarkers(String subcategoryTitle) {
    filteredMarkers.clear();
    filteredMarkers.addAll(Provider.of<DataService>(context, listen: false).markers);
    if(subcategoryTitle != Languages.of(context)!.cpDropdownDefault){
      filteredMarkers.removeWhere(
              (key, value) => !value.containsSubcategoryTitle(subcategoryTitle));
    }
    setState(() {
      chosenSubcategoryTitle = subcategoryTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    DataService dataService = Provider.of<DataService>(context, listen: false);
    List<String> dropdownValues = dataService.cpSubcategories.toList();
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
      floatingActionButton: loggedIn ? FloatingActionButton(
        child: const Icon(Icons.group),
        onPressed: () =>
            ComradeDialogWidget.showModal(context, chosenSubcategoryTitle),
      )
      : null,
    );
  }
}
