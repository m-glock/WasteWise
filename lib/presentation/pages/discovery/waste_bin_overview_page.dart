import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/icons/bsr_icons.dart';
import 'package:recycling_app/presentation/pages/discovery/waste_bin_page.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/discovery_tile.dart';
import 'package:recycling_app/presentation/util/waste_bin.dart';

import '../../util/Constants.dart';

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
        padding: EdgeInsets.all(Constants.pagePadding),
        child: ListView(
          children: [
            DiscoveryTile(
              leading: Container(
                color: Colors.white,
                child: const Icon(
                  BsrIcons.biologicalWaste,
                  size: 50,
                  color: Color.fromARGB(255, 113, 45, 36),
                ),
              ),
              title: Languages.of(context)!.wasteBinNames[WasteBin.biologicalWaste]!,
              subtitle: null,
              destinationPage: const WasteBinPage(wasteBin: WasteBin.biologicalWaste),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            DiscoveryTile(
              leading: Container(
                color: Colors.white,
                child: const Icon(
                  BsrIcons.residualWaste,
                  size: 50,
                  color: Color.fromARGB(255, 95, 106, 114),
                ),
              ),
              title: Languages.of(context)!.wasteBinNames[WasteBin.residualWaste]!,
              subtitle: null,
              destinationPage: const WasteBinPage(wasteBin: WasteBin.residualWaste),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            DiscoveryTile(
              leading: Container(
                color: Colors.white,
                child: const Icon(
                  BsrIcons.glass,
                  size: 50,
                  color: Color.fromARGB(255, 0, 144, 84),
                ),
              ),
              title: Languages.of(context)!.wasteBinNames[WasteBin.glassWaste]!,
              subtitle: null,
              destinationPage: const WasteBinPage(wasteBin: WasteBin.glassWaste),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            DiscoveryTile(
              leading: Container(
                color: Colors.white,
                child: const Icon(
                  BsrIcons.packaging,
                  size: 50,
                  color: Color.fromARGB(255, 248, 198, 0),
                ),
              ),
              title: Languages.of(context)!.wasteBinNames[WasteBin.recyclableWaste]!,
              subtitle: null,
              destinationPage: const WasteBinPage(wasteBin: WasteBin.recyclableWaste),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            DiscoveryTile(
              leading: Container(
                color: Colors.white,
                child: const Icon(
                  BsrIcons.paperWaste,
                  size: 50,
                  color: Color.fromARGB(255, 0, 85, 170),
                ),
              ),
              title: Languages.of(context)!.wasteBinNames[WasteBin.paperWaste]!,
              subtitle: null,
              destinationPage: const WasteBinPage(wasteBin: WasteBin.paperWaste),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            DiscoveryTile(
              leading: Container(
                color: Colors.white,
                child: const Icon(
                  BsrIcons.bicycle,
                  size: 50,
                  color: Color.fromARGB(255, 255, 106, 0),
                ),
              ),
              title: Languages.of(context)!.wasteBinNames[WasteBin.other]!,
              subtitle: null,
              destinationPage: const WasteBinPage(wasteBin: WasteBin.other),
            ),
          ],
        ),
      ),
    );
  }
}