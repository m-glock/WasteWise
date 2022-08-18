import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/pages/search/item_detail_page.dart';
import 'package:searchfield/searchfield.dart';

import '../../../util/item.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  //TODO: replace with items from BE
  List<Item> items = [
    Item("Hallo", "Hello, hola"),
    Item("Halogen", "homogen")
  ];

  void _getItemInfo(Item selected) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ItemDetailPage(item: selected)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SearchField<Item>(
      hint: "Search",
      maxSuggestionsInViewPort: 5,
      onSuggestionTap: (SearchFieldListItem selectedItem) {
        _getItemInfo(selectedItem.item as Item);
      },
      suggestions: items
          .map((element) => SearchFieldListItem<Item>(
          element.getWords(),
          item: element,
          child: Text(element.title)
      )).toList(),
      emptyWidget: Container(), //TODO: show when no suggestion was found
    );
  }
}
