import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/tip_page.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/tip_tile.dart';

import '../../i18n/locale_constant.dart';
import '../../util/Constants.dart';

class TipsAndTricksPage extends StatefulWidget {
  const TipsAndTricksPage({Key? key}) : super(key: key);

  @override
  State<TipsAndTricksPage> createState() => _TipsAndTricksPageState();
}

//TODO: add bookmarked
class _TipsAndTricksPageState extends State<TipsAndTricksPage> {
  //TODO: use translations for default value
  Map<String, String> wasteBinTypes = {"default": "All"};
  Map<String, String> tipTypes = {"default": "All"};
  late String wasteBinDefault;
  late String tipTypeDefault;
  List<dynamic> tips = [];

  @override
  void initState() {
    super.initState();
    _setFilterValuesToDefault();
    _getTips();
    _getTags();
  }

  void _getTags() async {
    final ParseCloudFunction function = ParseCloudFunction('getTipTypes');
    Locale locale = await getLocale();
    final Map<String, dynamic> params = <String, dynamic>{
      'languageCode': locale.languageCode,
    };
    final ParseResponse parseResponse =
    await function.execute(parameters: params);
    if (parseResponse.success && parseResponse.result != null) {
      List<dynamic> tipTypesBE = parseResponse.result;
      Map<String, String> objectIdTitlePairs = {};
      tipTypesBE.forEach((element) {
        objectIdTitlePairs[element["tip_type_id"]["objectId"]] = element["title"];
      });
      setState(() {
        tipTypes.addAll(objectIdTitlePairs);
      });
    } else {
      //TODO
    }
    // get categories and save them in tags with "objectId":"title"
  }

  void _getTips() async {
    final ParseCloudFunction function = ParseCloudFunction('getTips');
    Locale locale = await getLocale();
    final Map<String, dynamic> params = <String, dynamic>{
      'languageCode': locale.languageCode,
    };
    final ParseResponse parseResponse =
        await function.execute(parameters: params);
    if (parseResponse.success && parseResponse.result != null) {
      // TODO iterate through map/JSON and built Tip object for each
      setState(() {
        tips = parseResponse.result;
      });
    } else {
      //TODO
    }
  }

  void _setFilterValuesToDefault() {
    setState(() {
      wasteBinDefault = "All";
      tipTypeDefault = "All";
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
                      Text(Languages.of(context)!.dropdownTipTypeLabel),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: tipTypeDefault,
                        onChanged: (String? newValue) {
                          setState(() {
                            tipTypeDefault = newValue!;
                            //TODO: filter list
                          });
                        },
                        items: tipTypes.values
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
                      Text(Languages.of(context)!.dropdownWasteBinLabel),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: wasteBinDefault,
                              onChanged: (String? newValue) {
                                setState(() {
                                  //TODO: filter list
                                  wasteBinDefault = newValue!;
                                });
                              },
                              items: wasteBinTypes.values
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
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
                            onTap: () => {_setFilterValuesToDefault()},
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
              child: ListView(
                children: [
                  ...tips.map((element) {
                    return TipTile(
                      title: element["title"],
                      destinationPage: TipPage(tipTitle: element["title"]),
                      tags: [
                        tipTypes[element["tip_id"]["tip_type_id"]["objectId"]] ?? "",
                        wasteBinTypes[element["tip_id"]["category_id"]["objectId"]] ?? "",
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
