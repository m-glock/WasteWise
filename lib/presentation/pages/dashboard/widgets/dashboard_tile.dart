import 'package:flutter/material.dart';

import '../../../util/constants.dart';

class DashboardTile extends StatelessWidget {
  const DashboardTile({Key? key, required this.tileContent, this.onlyTitlePadding = false}) : super(key: key);

  final Widget tileContent;
  final bool onlyTitlePadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: Constants.tileBorderRadius,
      ),
      child: Padding(
        padding: onlyTitlePadding
            ? const EdgeInsets.only(top: 20, right: 20)
            : const EdgeInsets.all(20),
        child: Row(
          children: [
            tileContent,
          ],
        ),
      ),
    );
  }
}