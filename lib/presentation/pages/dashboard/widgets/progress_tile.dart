import 'package:flutter/material.dart';

import '../../../i18n/languages.dart';
import 'bar_chart_widget.dart';

class ProgressTile extends StatefulWidget {
  const ProgressTile({Key? key}) : super(key: key);

  @override
  State<ProgressTile> createState() => _ProgressTileState();
}

class _ProgressTileState extends State<ProgressTile> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Text(
                Languages.of(context)!.progressTileTitle,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const Expanded(
                  child: BarChartWidget(),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2)),
                        Text(
                          Languages.of(context)!.progressTileRecycledLabel,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2)),
                        Text(
                          Languages.of(context)!.progressTileSavedLabel,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
