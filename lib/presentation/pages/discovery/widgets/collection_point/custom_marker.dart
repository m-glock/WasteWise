import 'package:flutter/material.dart';

import '../../../../util/database_classes/collection_point.dart';
import 'map_marker_popup_widget.dart';

class CustomMarkerWidget extends StatefulWidget {
  const CustomMarkerWidget(
      {Key? key, this.collectionPoint, this.markerColor = Colors.black})
      : super(key: key);

  final CollectionPoint? collectionPoint;
  final Color markerColor;

  @override
  State<CustomMarkerWidget> createState() => _CustomMarkerWidgetState();
}

class _CustomMarkerWidgetState extends State<CustomMarkerWidget> {
  bool showPopup = false;

  void _togglePopup() {
    setState(() {
      showPopup = !showPopup;
    });
  }

  Widget _popup() {
    return MapMarkerPopupWidget(collectionPoint: widget.collectionPoint!);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runAlignment: WrapAlignment.end,
      alignment: WrapAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.end,
      //alignment: AlignmentDirectional.bottomCenter,
      children: [
        if (showPopup && widget.collectionPoint != null) _popup(),
        IconButton(
          iconSize: 35,
          color: widget.markerColor,
          onPressed: _togglePopup,
          icon: const Icon(Icons.location_on),
        ),
      ],
    );
  }
}
