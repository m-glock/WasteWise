import 'package:flutter/material.dart';

import '../../../util/collection_point.dart';
import 'map_marker_popup_widget.dart';

class CustomMarkerWidget extends StatefulWidget {
  const CustomMarkerWidget({Key? key, required this.collectionPoint}) : super(key: key);

  final CollectionPoint collectionPoint;

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
    return MapMarkerPopupWidget(collectionPoint: widget.collectionPoint);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      //alignment: AlignmentDirectional.bottomCenter,
      children: [
        if (showPopup) _popup(),
        IconButton(
          iconSize: 35,
          onPressed: _togglePopup,
          icon: const Icon(Icons.location_on),
        ),
      ],
    );
  }
}
