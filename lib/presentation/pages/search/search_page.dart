import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycling_app/presentation/pages/search/widgets/barcode_scan_page.dart';
import 'package:recycling_app/presentation/pages/search/widgets/search_bar.dart';

import '../../i18n/languages.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List recentlySearched = ["Styropor", "Asche", "Holz"];
  List oftenSearched = ["Korken", "Kleiderbügel", "Knochen"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBar(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                width: 170,
                child: ElevatedButton(
                  child: Row(
                    children: const [
                      Icon(FontAwesomeIcons.barcode, size: 12),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text('Barcode Scanner'),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BarcodeScanPage()),
                    );
                  },
                ),
              ),
            ),
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TODO replace with actual items and links
                    Text(Languages.of(context)!.recentlySearched,
                        style: Theme.of(context).textTheme.headline2),
                    const Padding(padding: EdgeInsets.only(bottom: 5)),
                    ...recentlySearched
                        .map((element) => Text(element,
                            style: Theme.of(context).textTheme.bodyText1))
                        .toList(),
                    const Padding(padding: EdgeInsets.only(bottom: 25)),
                    Text(Languages.of(context)!.oftenSearched,
                        style: Theme.of(context).textTheme.headline2),
                    const Padding(padding: EdgeInsets.only(bottom: 5)),
                    ...oftenSearched
                        .map((element) => Text(element,
                            style: Theme.of(context).textTheme.bodyText1))
                        .toList(),
                  ],
                ),
              ],
            ),
          ],
      ),
    );
  }
}
