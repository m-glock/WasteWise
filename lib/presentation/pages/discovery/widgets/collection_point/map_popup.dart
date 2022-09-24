import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../../i18n/languages.dart';
import '../../../../util/constants.dart';
import '../../../../util/database_classes/collection_point.dart';
import '../../collection_point_detail_page.dart';

class MapPopup extends StatefulWidget {
  const MapPopup(this.marker, this.collectionPoint, {Key? key})
      : super(key: key);

  final Marker marker;
  final CollectionPoint collectionPoint;

  @override
  State<StatefulWidget> createState() => _MapPopupState();
}

class _MapPopupState extends State<MapPopup> {

  void _openGoogleMapsForRoute() {
    MapsLauncher.launchCoordinates(
        widget.collectionPoint.address.location.latitude,
        widget.collectionPoint.address.location.longitude,
        widget.collectionPoint.collectionPointType.title);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Constants.tileBorderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  widget.collectionPoint.collectionPointType.title,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                Text(
                  widget.collectionPoint.address.toString(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CollectionPointDetailPage(
                                collectionPoint: widget.collectionPoint),
                          ),
                        )
                      },
                      child: Text(Languages.of(context)!.detailButtonText),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 5)),
                    OutlinedButton(
                      onPressed: _openGoogleMapsForRoute,
                      child: Text(Languages.of(context)!.routeButtonText),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}
