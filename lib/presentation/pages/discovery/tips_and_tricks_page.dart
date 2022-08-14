import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/tip_page.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/tip_tile.dart';

import '../../util/Constants.dart';

class TipsAndTricksPage extends StatefulWidget {
  const TipsAndTricksPage({Key? key}) : super(key: key);

  @override
  State<TipsAndTricksPage> createState() => _TipsAndTricksPageState();
}

class _TipsAndTricksPageState extends State<TipsAndTricksPage> {
  String dropdownValue1 = 'Alle';
  String dropdownValue2 = 'Alle';

  void _resetFilterValues() {
    setState(() {
      dropdownValue1 = 'Alle';
      dropdownValue2 = 'Alle';
      //TODO: reset filter of list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.tipsAndTricksTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Art des Tipps: "),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue1,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue1 = newValue!;
                            //TODO: filter list
                          });
                        },
                        items: <String>['Alle', 'Vermeidung', 'Trennung']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Art des Mülls: "),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: dropdownValue2,
                              onChanged: (String? newValue) {
                                setState(() {
                                  //TODO: filter list
                                  dropdownValue2 = newValue!;
                                });
                              },
                              items: <String>[
                                'Alle',
                                'Biotonne',
                                'Wertstofftonne',
                                'Restmüll'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 10)),
                          GestureDetector(
                            child: const Icon(FontAwesomeIcons.xmark),
                            onTap: () => {_resetFilterValues()},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Expanded(
              //TODO: get actual tips from server
              child: ListView(
                children: const [
                  TipTile(
                    title: "Eigenkompostierung ermöglichen",
                    destinationPage:
                        TipPage(tipTitle: "Eigenkompostierung ermöglichen"),
                    bookmarked: true,
                  ),
                  TipTile(
                    title: "Eigenkompostierung ermöglichen",
                    destinationPage:
                        TipPage(tipTitle: "Eigenkompostierung ermöglichen"),
                    bookmarked: false,
                  ),
                  TipTile(
                    title: "Eigenkompostierung ermöglichen",
                    destinationPage:
                        TipPage(tipTitle: "Eigenkompostierung ermöglichen"),
                    bookmarked: true,
                  ),
                  TipTile(
                    title: "Eigenkompostierung ermöglichen",
                    destinationPage:
                        TipPage(tipTitle: "Eigenkompostierung ermöglichen"),
                    bookmarked: false,
                  ),
                  TipTile(
                    title: "Eigenkompostierung ermöglichen",
                    destinationPage:
                        TipPage(tipTitle: "Eigenkompostierung ermöglichen"),
                    bookmarked: false,
                  ),
                  TipTile(
                    title: "Eigenkompostierung ermöglichen",
                    destinationPage:
                        TipPage(tipTitle: "Eigenkompostierung ermöglichen"),
                    bookmarked: false,
                  ),
                  TipTile(
                    title: "Eigenkompostierung ermöglichen",
                    destinationPage:
                        TipPage(tipTitle: "Eigenkompostierung ermöglichen"),
                    bookmarked: true,
                  ),
                  TipTile(
                    title: "Eigenkompostierung ermöglichen",
                    destinationPage:
                        TipPage(tipTitle: "Eigenkompostierung ermöglichen"),
                    bookmarked: false,
                  ),
                  TipTile(
                    title: "Eigenkompostierung ermöglichen",
                    destinationPage:
                        TipPage(tipTitle: "Eigenkompostierung ermöglichen"),
                    bookmarked: false,
                  ),
                  TipTile(
                    title: "Eigenkompostierung ermöglichen",
                    destinationPage:
                        TipPage(tipTitle: "Eigenkompostierung ermöglichen"),
                    bookmarked: true,
                  ),
                  TipTile(
                    title: "Eigenkompostierung ermöglichen",
                    destinationPage:
                        TipPage(tipTitle: "Eigenkompostierung ermöglichen"),
                    bookmarked: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
