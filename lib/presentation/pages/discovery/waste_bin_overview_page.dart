import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/waste_bin_page.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/discovery_tile.dart';
import 'package:recycling_app/presentation/util/HexColor.dart';

import '../../i18n/locale_constant.dart';
import '../../util/Constants.dart';

class WasteBinOverviewPage extends StatefulWidget {
  const WasteBinOverviewPage({Key? key}) : super(key: key);

  @override
  State<WasteBinOverviewPage> createState() => _WasteBinOverviewPageState();
}

class _WasteBinOverviewPageState extends State<WasteBinOverviewPage> {
  List<dynamic> categories = [];

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  void _getCategories() async {
    final ParseCloudFunction function = ParseCloudFunction('getCategories');
    Locale locale = await getLocale();
    final Map<String, dynamic> params = <String, dynamic>{
      'languageCode': locale.languageCode,
    };
    final ParseResponse parseResponse =
        await function.execute(parameters: params);
    if (parseResponse.success && parseResponse.result != null) {
      setState(() {
        categories = parseResponse.result;
      });
    } else {
      //TODO
    }
  }

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
            ...categories.map((element) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DiscoveryTile(
                  leading: SvgPicture.network(
                    element["category_id"]["image_file"]["url"],
                    width: 50,
                    height: 50,
                    color:
                        HexColor.fromHex(element["category_id"]["hex_color"]),
                  ),
                  title: element["title"],
                  subtitle: null,
                  //TODO remove from languages?
                  destinationPage: WasteBinPage(wasteBinName: element["title"]),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
