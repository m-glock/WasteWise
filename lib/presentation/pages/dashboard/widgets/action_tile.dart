import 'package:flutter/material.dart';

import '../../../i18n/languages.dart';

class ActionTile extends StatefulWidget {
  const ActionTile({Key? key}) : super(key: key);

  @override
  State<ActionTile> createState() => _ActionTileState();
}

class _ActionTileState extends State<ActionTile> {

  //TODO: replace with actual tip of the day
  String tileContent = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Center(
            child: Text(
              Languages.of(context)!.tipTileTitle,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Text(
            tileContent,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          OutlinedButton(
            child: Text(Languages.of(context)!.tipTileButtonText),
            onPressed: () {
              print("Button pressed");
            },
          )
        ],
      ),
    );
  }
}
