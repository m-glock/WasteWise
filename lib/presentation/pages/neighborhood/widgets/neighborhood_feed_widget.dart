import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../notification_page.dart';

class NeighborhoodFeedWidget extends StatefulWidget {
  const NeighborhoodFeedWidget({Key? key}) : super(key: key);

  @override
  State<NeighborhoodFeedWidget> createState() => _NeighborhoodFeedWidgetState();
}

class _NeighborhoodFeedWidgetState extends State<NeighborhoodFeedWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Neighborhood Feed"),
          //TODO
          IconButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationPage()),
              )
            },
            icon: const Icon(FontAwesomeIcons.bell),
          ),
        ],
      ),
    );
  }
}
