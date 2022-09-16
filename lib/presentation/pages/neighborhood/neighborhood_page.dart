import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/neighborhood/widgets/neighborhood_feed_widget.dart';

class NeighborhoodPage extends StatefulWidget {
  const NeighborhoodPage({Key? key}) : super(key: key);

  @override
  State<NeighborhoodPage> createState() => _NeighborhoodPageState();
}

class _NeighborhoodPageState extends State<NeighborhoodPage> {
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkIfAuthenticated();
  }

  void _checkIfAuthenticated() async {
    ParseUser? currentUser = await ParseUser.currentUser();
    setState(() {
      _isAuthenticated = currentUser != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isAuthenticated
          ? const NeighborhoodFeedWidget()
          : Center(
              child:
                  Text(Languages.of(context)!.neighborhoodNotAuthenticatedText),
            ),
    );
  }
}
