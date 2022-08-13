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
            IconButton( //TODO: replace iconbutton with smartfilter
              iconSize: 25,
              splashRadius: 5,
              padding: const EdgeInsets.all(0),
              icon: const Icon(FontAwesomeIcons.filter),
              onPressed: () => {
                //TODO add filter
              },
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Expanded(
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
