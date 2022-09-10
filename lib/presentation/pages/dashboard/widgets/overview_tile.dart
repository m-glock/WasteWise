import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';

import '../../../i18n/languages.dart';

class OverviewTile extends StatefulWidget {
  const OverviewTile({Key? key}) : super(key: key);

  @override
  State<OverviewTile> createState() => _OverviewTileState();
}

class _OverviewTileState extends State<OverviewTile> {
  Widget _richText(int amount, String text){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Text.rich(
        TextSpan(
          text: amount.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          children: <TextSpan>[
            TextSpan(
                text: text,
                style: Theme.of(context).textTheme.bodyText1
            ),
          ],
        ),
      ),
    );
  }

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
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          _richText(
            DataHolder.amountOfSearchedItems ?? 0,
            Languages.of(context)!.overviewTileRecycledText,
          ),
          _richText(
              DataHolder.amountOfRescuedItems ?? 0,
              Languages.of(context)!.overviewTileSavedText,
          ),
        ],
      ),
    );
  }
}
