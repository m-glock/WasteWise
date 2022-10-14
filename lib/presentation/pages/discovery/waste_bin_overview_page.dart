import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/waste_bin_detail_page.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/tips/discovery_tile.dart';
import '../../../logic/services/data_service.dart';
import '../../../logic/util/constants.dart';

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
            ...Provider.of<DataService>(context, listen: false).categoriesById.values.map((category) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DiscoveryTile(
                  leading: Image.file(
                    File(category.imageFilePath),
                    width: 50,
                    height: 50,
                  ),
                  title: category.title,
                  subtitle: null,
                  destinationPage: WasteBinDetailPage(wasteBin: category),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
