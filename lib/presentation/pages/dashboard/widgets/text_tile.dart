import 'package:flutter/material.dart';

import '../../../i18n/languages.dart';

class TextTile extends StatefulWidget {
  const TextTile({Key? key}) : super(key: key);

  @override
  State<TextTile> createState() => _TextTileState();
}

class _TextTileState extends State<TextTile> {

  //TODO: replace with actual percentage
  String percentage = "10%";

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Center(
            child: Text(
              Languages.of(context)!.congratsTileTitle,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Text.rich(
            TextSpan(
              text: Languages.of(context)!.congratsTileFirstFragment,
              style: Theme.of(context).textTheme.bodyText1,
              children: <TextSpan>[
                TextSpan(
                    text: percentage,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                ),
                TextSpan(
                    text: Languages.of(context)!.congratsTileSecondFragment,
                    style: Theme.of(context).textTheme.bodyText1
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
