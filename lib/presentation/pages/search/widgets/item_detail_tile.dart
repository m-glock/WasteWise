import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ItemDetailTile extends StatefulWidget {
  const ItemDetailTile(
      {Key? key, required this.headerTitle, required this.expandedWidget})
      : super(key: key);

  final String headerTitle;
  final Widget expandedWidget;

  @override
  State<ItemDetailTile> createState() => _ItemDetailTileState();
}

class _ItemDetailTileState extends State<ItemDetailTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
          headerAlignment: ExpandablePanelHeaderAlignment.center,
        ),
        header: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Text(
            widget.headerTitle,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        collapsed: const SizedBox.shrink(),
        expanded: Container(
          padding: const EdgeInsets.fromLTRB(25, 0, 20, 25),
          child: widget.expandedWidget,
        ),
      ),
    );
  }
}
