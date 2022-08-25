import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/pages/search/widgets/search_sort_grid_tile.dart';
import 'package:recycling_app/presentation/util/constants.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';

import '../../i18n/languages.dart';
import '../../util/database_classes/waste_bin_category.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Constants.pagePadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(Languages.of(context)!.searchSortQuestion, style: Theme.of(context).textTheme.headline3,),
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: <Widget>[
                  ...DataHolder.categories.map((category) {
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
      ),
    );
  }
}
