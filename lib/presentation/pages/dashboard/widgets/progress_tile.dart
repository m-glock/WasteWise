import 'package:flutter/material.dart';

import '../../../i18n/languages.dart';

class ProgressTile extends StatefulWidget {
  const ProgressTile({Key? key}) : super(key: key);

  @override
  State<ProgressTile> createState() => _ProgressTileState();
}

class _ProgressTileState extends State<ProgressTile> {

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Text(
                Languages.of(context)!.progressTileTitle,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}