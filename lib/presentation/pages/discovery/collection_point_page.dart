import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/collection_point/comrade_dialog_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/collection_point/custom_marker.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/collection_point/map_filter_dropdown_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/collection_point/map_widget.dart';
import 'package:recycling_app/presentation/util/constants.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';
import 'package:latlong2/latlong.dart';
import 'package:recycling_app/presentation/util/graphl_ql_queries.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../i18n/locale_constant.dart';
import '../../util/database_classes/collection_point.dart';
import '../../util/database_classes/collection_point_type.dart';
import '../../util/database_classes/subcategory.dart';

class CollectionPointPage extends StatefulWidget {
  const CollectionPointPage({Key? key}) : super(key: key);

  @override
  State<CollectionPointPage> createState() => _CollectionPointPageState();
}

class _CollectionPointPageState extends State<CollectionPointPage> {
  LatLng currentPosition = LatLng(52.5200, 13.4050);
  Map<CollectionPoint, Marker> filteredMarkers = {};
  String languageCode = "";
  String municipalityId = "";
  String? chosenSubcategoryTitle;

  @override
  void initState() {
    super.initState();
    _getLanguageCodeAndMunicipality();
    _determinePosition();
  }

  void _getLanguageCodeAndMunicipality() async {
    Locale locale = await getLocale();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? id = _prefs.getString(Constants.prefSelectedMunicipalityCode);
    setState(() {
      languageCode = locale.languageCode;
      municipalityId = id ?? "";
    });
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
    chosenSubcategoryTitle = subcategoryTitle;
    setState(() {
      filteredMarkers.addAll(DataHolder.markers);
      filteredMarkers.removeWhere(
          (key, value) => !key.containsSubcategoryTitle(subcategoryTitle));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.collectionPointsTitle),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(GraphQLQueries.collectionPointQuery),
          variables: {
            "languageCode": languageCode,
            "municipalityId": municipalityId,
          },
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) return Text(result.exception.toString());
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // get collection point types
          List<dynamic> collectionPointTypes =
              result.data?["getCollectionPointTypes"];
          for (dynamic cpType in collectionPointTypes) {
            DataHolder.collectionPointTypes
                .add(CollectionPointType.fromJson(cpType));
          }

          // get collection points
          List<dynamic> collectionPoints = result.data?["getCollectionPoints"];

          // build markers for collection points
          Map<String, CollectionPoint> cpByObjectId = {};
          for (dynamic cp in collectionPoints) {
            CollectionPoint collectionPoint = CollectionPoint.fromJson(cp);
            cpByObjectId[collectionPoint.objectId] = collectionPoint;
            Marker marker = Marker(
              anchorPos: AnchorPos.align(AnchorAlign.top),
              width: 220,
              height: 200,
              point: collectionPoint.address.location,
              builder: (ctx) =>
                  CustomMarkerWidget(collectionPoint: collectionPoint),
            );
            DataHolder.markers[collectionPoint] = marker;
          }
          if (filteredMarkers.isEmpty) {
            filteredMarkers.addAll(DataHolder.markers);
          }

          // get accepted subcategories for all collection points
          List<dynamic> subcategoriesOfCP =
              result.data?["getSubcategoriesOfAllCollectionPoints"];
          for (dynamic subcategoryCpPair in subcategoriesOfCP) {
            String collectionPointObjectId =
                subcategoryCpPair["collection_point_id"]["objectId"];
            String subcategoryObjectId =
                subcategoryCpPair["subcategory_id"]["objectId"];
            Subcategory? subcategory =
                DataHolder.subcategoriesById[subcategoryObjectId];
            if (subcategory != null) {
              cpByObjectId[collectionPointObjectId]
                  ?.acceptedSubcategories
                  .add(subcategory);
            }
          }

          // get available subcategories for filter dropdown
          List<dynamic> availableSubcategories =
              result.data?["getDistinctSubcategoriesForCP"];
          for (dynamic element in availableSubcategories) {
            DataHolder.cpSubcategories.add(element["title"]);
          }
          chosenSubcategoryTitle = DataHolder.cpSubcategories.first;

          // display when all data is available
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: MapFilterDropdownWidget(
                  dropdownValues: DataHolder.cpSubcategories.toList(),
                  updateMarkersInParent: _filterMarkers,
                ),
              ),
              Flexible(
                  child: MapWidget(
                marker: filteredMarkers,
                currentPosition: currentPosition,
              )),
            ],
          );
        },
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
