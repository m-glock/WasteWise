import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/collection_point_page.dart';
import 'package:recycling_app/presentation/pages/discovery/tips_and_tricks_page.dart';
import 'package:recycling_app/presentation/pages/discovery/waste_bin_overview_page.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/discovery_tile.dart';
import 'package:recycling_app/presentation/custom_icons.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {

  final double iconSize = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DiscoveryTile(
            leading: Icon(CustomIcons.garbageCan, size: iconSize),
            title: Languages.of(context)!.wasteBinOverviewTitle,
            subtitle: Languages.of(context)!.wasteBinOverviewSubtitle,
            destinationPage: const WasteBinOverviewPage(),
          ),
          const Padding(padding: EdgeInsets.all(5)),
          DiscoveryTile(
            leading: Icon(CustomIcons.lightbulb, size: iconSize),
            title: Languages.of(context)!.tipsAndTricksTitle,
            subtitle: Languages.of(context)!.tipsAndTricksSubtitle,
            destinationPage: const TipsAndTricksPage(),
          ),
          const Padding(padding: EdgeInsets.all(5)),
          DiscoveryTile(
            leading: Icon(CustomIcons.map, size: iconSize),
            title: Languages.of(context)!.collectionPointsTitle,
            subtitle: Languages.of(context)!.collectionPointsSubtitle,
            destinationPage: const CollectionPointPage(),
          ),
        ],
      ),
    );
  }
}
