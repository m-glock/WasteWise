import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/map_filter_dropdown_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/map_marker_popup_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/map_widget.dart';
import 'package:recycling_app/presentation/util/collection_point.dart';

import '../../i18n/locale_constant.dart';

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
      getCollectionPoints(municipalityId: \$municipalityId){
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
        }
      }
      
      getCollectionPointSubcategories(languageCode: \$languageCode, municipalityId: \$municipalityId){
        objectId
		    title
      }
      
      getCollectionPointTypes(languageCode: \$languageCode){
        title
        collection_point_type_id{
          objectId
        }
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
    return MapMarkerPopupWidget(collectionPoint: current!);
  }

  void _togglePopup(CollectionPoint selected) {
    setState(() {
      current = current?.objectId == selected.objectId ? null : selected;
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
          List<dynamic> collectionPointTypes =
              result.data?["getCollectionPointTypes"];

          if (collectionPoints.isEmpty ||
              availableSubcategories.isEmpty ||
              collectionPointTypes.isEmpty) {
            return const Text("No collection points or subcategories found.");
          }

          // build markers for collection points
          final Map<Marker, CollectionPoint> markers = {};
          for (dynamic element in collectionPoints) {
            CollectionPoint collectionPoint =
                CollectionPoint(element, collectionPointTypes);
            Marker marker = Marker(
              anchorPos: AnchorPos.align(AnchorAlign.top),
              width: 220,
              height: 200,
              point: collectionPoint.address.location,
              builder: (ctx) => Column(
                mainAxisAlignment: MainAxisAlignment.end,
                //alignment: AlignmentDirectional.bottomCenter,
                children: [
                  if (current?.objectId == collectionPoint.objectId) _popup(),
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

          // display when all data is available
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: MapFilterDropdownWidget(
                  dropdownValues: dropdownValues,
                ),
              ),
              Flexible(
                  child: MapWidget(
                      defaultLocation: defaultLatLng, marker: markers)),
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
