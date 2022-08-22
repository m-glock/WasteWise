import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/util/address.dart';
import 'package:recycling_app/presentation/util/collection_point.dart';

import '../../i18n/locale_constant.dart';
import '../../util/collection_point_type.dart';
import '../../util/contact.dart';

class CollectionPointPage extends StatefulWidget {
  const CollectionPointPage({Key? key}) : super(key: key);

  @override
  State<CollectionPointPage> createState() => _CollectionPointPageState();
}

class _CollectionPointPageState extends State<CollectionPointPage> {
  //TODO ask user for current location
  final LatLng defaultLatLng = LatLng(52.5200, 13.4050);
  String languageCode = "";
  String query = """
    query GetCollectionPoints(\$languageCode: String!, \$municipalityId: String!){
      getCollectionPoints(languageCode: \$languageCode, municipalityId: \$municipalityId){
        objectId
        opening_hours
        link
        contact_id{
          phone
          fax
          email
        }
        address_id{
          street
          number
          zip_code
          district
          location{
            latitude
            longitude
          }
        }
        collection_point_type_id{
          objectId
    	    image
        }
      }
      
      getCollectionPointSubcategories(languageCode: \$languageCode, municipalityId: \$municipalityId){
        objectId
		    title
      }
    }
  """;

  @override
  void initState() {
    super.initState();
    _getLanguageCode();
  }

  void _getLanguageCode() async {
    Locale locale = await getLocale();
    setState(() {
      languageCode = locale.languageCode;
    });
  }

  CollectionPoint? current;

  Widget _popup() {
    return Container(
      color: Colors.lightGreen,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(current!.collectionPointType.title),
          Text(current!.address.toString()),
          Row(
            children: [
              ElevatedButton(onPressed: () => {}, child: Text("Details")),
              ElevatedButton(onPressed: () => {}, child: Text("Route planen")),
            ],
          )
        ],
      )
    );
  }

  void _togglePopup(CollectionPoint selected){
    setState(() {
      current = current?.objectId == selected.objectId
          ? null
          : selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.collectionPointsTitle),
      ),
      body: Query(
        options: QueryOptions(document: gql(query), variables: {
          "languageCode": languageCode,
          "municipalityId": "PMJEteBu4m" //TODO get from user
        }),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) return Text(result.exception.toString());
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          List<dynamic> collectionPoints = result.data?["getCollectionPoints"];
          List<dynamic> availableSubcategories =
              result.data?["getCollectionPointSubcategories"];

          if (collectionPoints.isEmpty || availableSubcategories.isEmpty) {
            return const Text("No collection points or subcategories found.");
          }

          // build markers for collection points
          final Map<Marker, CollectionPoint> markers = {};
          for (dynamic element in collectionPoints) {
            CollectionPointType cpType = CollectionPointType(
                element["collection_point_type_id"]["objectId"],
                "Unknown", //TODO: get translation of collection point type
                element["collection_point_type_id"]["image"] //TODO
                );
            Address address = Address(
                element["address_id"]["street"],
                element["address_id"]["number"],
                element["address_id"]["zip_code"],
                element["address_id"]["district"],
                LatLng(element["address_id"]["location"]["latitude"],
                    element["address_id"]["location"]["longitude"]));
            Contact contact = Contact(element["contact_id"]["phone"],
                element["contact_id"]["fax"], element["contact_id"]["email"]);
            CollectionPoint collectionPoint = CollectionPoint(element["objectId"], element["link"],
                element["opening_hours"], contact, address, cpType);
            Marker marker = Marker(
              width: 100,
              height: 100,
              point: collectionPoint.address.location,
              builder: (ctx) => Column(
                mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(current?.objectId == collectionPoint.objectId) _popup(),
                    IconButton(
                        iconSize: 35,
                        onPressed: () => _togglePopup(collectionPoint),
                        icon: const Icon(Icons.location_on),
                      ),
                  ],
                ),
            );
            markers[marker] = collectionPoint;
          }

          // get available subcategories for filter dropdown
          final List<String> dropdownValues = [];
          for (dynamic element in availableSubcategories) {
            dropdownValues.add(element["title"]);
          }
          String dropdownValue = dropdownValues.first;

          // display when all data is available
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(Languages.of(context)!.filterLabelItemType),
                    const Padding(padding: EdgeInsets.only(right: 5)),
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: dropdownValues
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
                    zoom: 13,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                      userAgentPackageName: 'com.glock.recyclingapp',
                    ),
                    MarkerLayerOptions(markers: markers.keys.toList()),
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
          );
        },
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
