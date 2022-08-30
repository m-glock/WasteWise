import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/pages/search/widgets/barcode_scanner_button.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';
import 'package:recycling_app/presentation/pages/search/widgets/search_bar.dart';

import '../../i18n/languages.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> recentlySearched = ["Styropor", "Asche", "Holz"];
  List<String> oftenSearched = ["Korken", "Kleiderbügel", "Knochen"];

  List<Widget> _itemList(List<String> listOfNames) {
    return listOfNames
        .map((element) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child:
                  Text(element, style: Theme.of(context).textTheme.bodyText1),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(itemNames: DataHolder.itemNames),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 40),
              child: BarcodeScannerButton(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //TODO replace with actual items and links
                Text(Languages.of(context)!.recentlySearched,
                    style: Theme.of(context).textTheme.headline3),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                ..._itemList(recentlySearched),
                const Padding(padding: EdgeInsets.only(bottom: 25)),
                Text(Languages.of(context)!.oftenSearched,
                    style: Theme.of(context).textTheme.headline3),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                ..._itemList(oftenSearched),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
