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
      "Du bist in den Top 10% deiner Nachbarschaft.";

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Center(
            child: Text(
              Languages.of(context)!.congratsTileTitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const Padding(padding: EdgeInsets.all(5)),
          Text(
            tileContent,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
