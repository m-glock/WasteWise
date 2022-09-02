import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycling_app/presentation/util/database_classes/search_history_item.dart';

import '../../../util/constants.dart';

class HistoryTile extends StatefulWidget {
  const HistoryTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SearchHistoryItem item;

  @override
  State<HistoryTile> createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  String _getDateString(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Constants.tileBorderRadius,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.item.title,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          _getDateString(widget.item.createdAt),
                          style: Theme.of(context).textTheme.headline3,
                        )
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  Expanded(
                    child: Row(
                      children: [
                        SvgPicture.network(
                          widget.item.selectedCategory.pictogramUrl,
                          color: widget.item.selectedCategory.color,
                          height: 30,
                          width: 30,
                          alignment: Alignment.centerLeft,
                        ),
                        const Padding(padding: EdgeInsets.only(right: 10)),
                        SvgPicture.network(
                          widget.item.item.wasteBin.pictogramUrl,
                          color: widget.item.item.wasteBin.color,
                          height: 30,
                          width: 30,
                          alignment: Alignment.centerLeft,
                        ),
                      ],
                    ),
                  ),
                  const Icon(FontAwesomeIcons.angleRight),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
