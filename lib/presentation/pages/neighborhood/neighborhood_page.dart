import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/neighborhood/widgets/neighborhood_feed_widget.dart';

import '../../util/constants.dart';
import '../../util/custom_icon_button.dart';

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
      body: Padding(
        padding: EdgeInsets.all(Constants.pagePadding),
        child: _isAuthenticated
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomIconButton(
                    onPressed: () => {},
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    icon: const Icon(FontAwesomeIcons.filter),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: Constants.tileBorderRadius,
                    ),
                    height: 70,
                    width: double.infinity,
                    child: const Text("Placeholder 'Write question'"),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  const NeighborhoodFeedWidget(),
                ],
              )
            : Center(
                child: Text(
                    Languages.of(context)!.neighborhoodNotAuthenticatedText),
              ),
      ),
    );
  }
}
