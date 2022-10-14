import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recycling_app/logic/database_access/mutations/search_mutations.dart';
import 'package:recycling_app/presentation/pages/search/widgets/alert_dialog_widget.dart';

import '../../../../model_classes/item.dart';
import '../../../../model_classes/waste_bin_category.dart';

class SearchSortGridTile extends StatefulWidget {
  const SearchSortGridTile(
      {Key? key,
      required this.category,
      required this.isCorrect,
      required this.item})
      : super(key: key);

  final WasteBinCategory category;
  final bool isCorrect;
  final Item item;

  @override
  State<SearchSortGridTile> createState() => _SearchSortGridTileState();
}

class _SearchSortGridTileState extends State<SearchSortGridTile> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.file(
            File(widget.category.imageFilePath),
            width: 100,
            height: 100,
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Text(
            widget.category.title,
            style: Theme.of(context).textTheme.labelMedium,
          )
        ],
      ),
      onTap: () {
        SearchMutations.addToSearchHistory(
            context,
            widget.item.objectId,
            widget.category.objectId,
            widget.category == widget.item.wasteBin
        );
        AlertDialogWidget.showModal(
            context, widget.item, widget.isCorrect);
      },
    );
  }
}
