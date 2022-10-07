import 'package:flutter/material.dart';

import '../../../../logic/util/constants.dart';

class DashboardTile extends StatelessWidget {
  const DashboardTile({
    Key? key,
    required this.tileContent,
    this.padding = const EdgeInsets.all(20)}) : super(key: key);

  final Widget tileContent;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: Constants.tileBorderRadius,
      ),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            tileContent,
          ],
        ),
      ),
    );
  }
}