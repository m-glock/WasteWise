import 'package:flutter/material.dart';

import '../../../i18n/languages.dart';

class ActionTile extends StatefulWidget {
  const ActionTile({Key? key}) : super(key: key);

  @override
  State<ActionTile> createState() => _ActionTileState();
}

class _ActionTileState extends State<ActionTile> {

  //TODO: replace with actual tip of the day
  String tileContent = "Remember to separate the lid from the cup.";

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
          const Padding(padding: EdgeInsets.symmetric(vertical: 7)),
          Text(
            tileContent,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Flexible(
              child: TextButton(
                child: Row(
                  children: [
                    const Icon(Icons.arrow_forward_ios_sharp, size: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(Languages.of(context)!.tipTileButtonText),
                    )
                  ],
                ),
                onPressed: () {
                  //TODO: open Tip
                },
              ),
          ),

        ],
      ),
    );
  }
}
