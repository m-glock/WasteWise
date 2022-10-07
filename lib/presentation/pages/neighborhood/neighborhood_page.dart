import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/neighborhood/widgets/neighborhood_feed_widget.dart';

import '../../../logic/util/user.dart';

class NeighborhoodPage extends StatefulWidget {
  const NeighborhoodPage({Key? key}) : super(key: key);

  @override
  State<NeighborhoodPage> createState() => _NeighborhoodPageState();
}

class _NeighborhoodPageState extends State<NeighborhoodPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (BuildContext context, User user, child) {
      return Scaffold(
        body: user.currentUser != null
            ? const NeighborhoodFeedWidget()
            : Center(
                child: Text(
                    Languages.of(context)!.neighborhoodNotAuthenticatedText),
              ),
      );
    });
  }
}
