import 'package:flutter/material.dart';

import '../../../i18n/languages.dart';

class OverviewTile extends StatefulWidget {
  const OverviewTile({Key? key}) : super(key: key);

  @override
  State<OverviewTile> createState() => _OverviewTileState();
}

class _OverviewTileState extends State<OverviewTile> {

  //TODO: replace with actual text
  String tileContent =
      "You are in the top 10% in your neighborhood.";

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Text(
                Languages.of(context)!.overviewTileTitle,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Text(
              Languages.of(context)!.overviewTileRecycledText,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Text(
              Languages.of(context)!.overviewTileSavedText,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}