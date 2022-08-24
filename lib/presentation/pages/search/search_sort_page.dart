import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/pages/search/widgets/search_sort_grid_tile.dart';
import 'package:recycling_app/presentation/util/constants.dart';

import '../../i18n/languages.dart';
import '../../util/waste_bin_category.dart';

class SearchSortPage extends StatefulWidget {
  const SearchSortPage(
      {Key? key,
      required this.itemObjectId,
      required this.correctCategory,
      required this.itemName})
      : super(key: key);

  final String itemObjectId;
  final WasteBinCategory? correctCategory;
  final String itemName;

  @override
  State<SearchSortPage> createState() => _SearchSortPageState();
}

class _SearchSortPageState extends State<SearchSortPage> {
  //TODO: get from somewhere
  final List<WasteBinCategory> categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemName),
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.pagePadding),
        child: Column(
          children: [
            Text(Languages.of(context)!.searchSortQuestion),
            GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: [
                ...categories.map((category) {
                  return SearchSortGridTile(
                    category: category,
                    isCorrect:
                        category.objectId == widget.correctCategory?.objectId,
                    itemObjectId: widget.itemObjectId,
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
