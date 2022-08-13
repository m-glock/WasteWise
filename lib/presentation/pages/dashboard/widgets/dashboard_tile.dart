import 'package:flutter/material.dart';

import '../../../util/Constants.dart';

class DashboardTile extends StatefulWidget {
  const DashboardTile({Key? key, required this.tileContent}) : super(key: key);

  final Widget tileContent;

  @override
  State<DashboardTile> createState() => _DashboardTileState();
}

class _DashboardTileState extends State<DashboardTile> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: Constants.tileBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            widget.tileContent,
          ],
        ),
      ),
    );
  }
}