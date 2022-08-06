import 'package:flutter/material.dart';

import '../../../i18n/languages.dart';

class TextTile extends StatefulWidget {
  const TextTile({Key? key}) : super(key: key);

  @override
  State<TextTile> createState() => _TextTileState();
}

class _TextTileState extends State<TextTile> {

  //TODO: replace with actual text
  String tileContent =
      "You are in the top 10% in your neighborhood.";

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Center(
            child: Text(
              Languages.of(context)!.congratsTileTitle,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          const Padding(padding: EdgeInsets.all(7)),
          Text(
            tileContent,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
