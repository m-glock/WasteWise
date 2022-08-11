import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/tips_and_tricks_page.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/discovery_tile.dart';

class WasteBinOverviewPage extends StatefulWidget {
  const WasteBinOverviewPage({Key? key}) : super(key: key);

  @override
  State<WasteBinOverviewPage> createState() => _WasteBinOverviewPageState();
}

class _WasteBinOverviewPageState extends State<WasteBinOverviewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.wasteBinOverviewTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: const [
              DiscoveryTile(
                  leading: Icon(Icons.access_alarm_outlined),
                  title: "Biotonne",
                  subtitle: "biologischer Abfall",
                  destinationPage: TipsAndTricksPage()
              ),
            ],
          ),
        ),
      ),
    );
  }
}