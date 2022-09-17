import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/pages/search/widgets/search_sort_grid_tile.dart';
import 'package:recycling_app/presentation/util/constants.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';

import '../../i18n/languages.dart';
import '../../util/database_classes/item.dart';

class SearchSortPage extends StatefulWidget {
  const SearchSortPage(
      {Key? key, required this.item})
      : super(key: key);

  final Item item;

  @override
  State<SearchSortPage> createState() => _SearchSortPageState();
}

class _SearchSortPageState extends State<SearchSortPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
      ),
      body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Constants.pagePadding),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      Languages.of(context)!.searchSortQuestion,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: <Widget>[
                      ...DataHolder.categoriesById.values.map((category) {
                        return SearchSortGridTile(
                          category: category,
                          isCorrect:
                              category.objectId == widget.item.wasteBin.objectId,
                          item: widget.item,
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
