import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../i18n/languages.dart';
import '../../../icons/custom_icons.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(CustomIcons.lightbulb),
              const Padding(padding: EdgeInsets.only(right: 5)),
              Center(
                child: Text(
                  Languages.of(context)!.tipTileTitle,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 7)),
          Expanded(
            child: Text(
              tileContent,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Flexible(
            child: TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(FontAwesomeIcons.angleRight, size: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      Languages.of(context)!.tipTileButtonText,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
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
