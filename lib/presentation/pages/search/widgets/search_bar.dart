import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/search/item_detail_page.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  //TODO: replace with items from BE
  List<String> items = ["Hallo", "Hello", "hola", "Halogen", "homogen"];
  final GlobalKey<AutoCompleteTextFieldState<String>> _key = GlobalKey();

  void _getItemInfo(String selected) {
    //TODO: check if BE returns an item before opening the page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ItemDetailPage(item: selected)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                size: 20,
              ),
            ),
            Expanded(
              child: AutoCompleteTextField<String>(
                suggestions: items,
                decoration: InputDecoration.collapsed(
                  hintText: Languages.of(context)!.searchBarHint,
                ),
                showCursor: false,
                style: const TextStyle(fontSize: 15),
                itemSorter: (String item1, String item2) {
                  return item1.compareTo(item2);
                },
                itemBuilder: (BuildContext context, Object? suggestion) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(suggestion.toString()),
                  );
                },
                textSubmitted: (String data) {
                  if (items.contains(data)) {
                    _getItemInfo(data);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //TODO: Snackbar or modal?
                      content:
                          Text(Languages.of(context)!.searchBarItemNotExist),
                    ));
                  }
                },
                itemSubmitted: (String data) {
                  _getItemInfo(data);
                },
                key: _key,
                itemFilter: (String suggestion, String query) {
                  //TODO contains?
                  return suggestion
                      .toLowerCase()
                      .startsWith(query.toLowerCase());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
