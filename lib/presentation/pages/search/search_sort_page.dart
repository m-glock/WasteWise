import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/presentation/pages/search/widgets/search_sort_grid_tile.dart';
import 'package:recycling_app/logic/util/constants.dart';

import '../../../logic/services/data_service.dart';
import '../../../model_classes/item.dart';
import '../../i18n/languages.dart';

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
                      ...Provider.of<DataService>(context, listen: false).categoriesById.values.map((category) {
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
