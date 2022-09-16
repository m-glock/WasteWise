import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/waste_bin_detail_page.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/tips/discovery_tile.dart';
import '../../util/constants.dart';

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
            ...DataHolder.categoriesById.values.map((category) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DiscoveryTile(
                  leading: CachedNetworkImage(
                    imageUrl: category.pictogramUrl,
                    width: 50,
                    height: 50,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
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
