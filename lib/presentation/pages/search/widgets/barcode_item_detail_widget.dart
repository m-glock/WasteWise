import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/util/constants.dart';
import 'package:recycling_app/presentation/util/database_classes/barcode_material.dart';
import 'package:recycling_app/presentation/util/database_classes/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../i18n/languages.dart';
import '../../../i18n/locale_constant.dart';
import '../../../util/BarcodeResult.dart';
import '../../../util/data_holder.dart';
import '../../../util/graphl_ql_queries.dart';

class BarcodeItemDetailPage extends StatefulWidget {
  const BarcodeItemDetailPage({Key? key, required this.responseBody})
      : super(key: key);

  final String responseBody;

  @override
  State<BarcodeItemDetailPage> createState() => _BarcodeItemDetailPageState();
}

class _BarcodeItemDetailPageState extends State<BarcodeItemDetailPage> {
  String? languageCode;
  String? municipalityId;

  @override
  void initState() {
    super.initState();
    _getLanguageCode();
  }

  void _getLanguageCode() async {
    Locale locale = await getLocale();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? id = _prefs.getString(Constants.prefSelectedMunicipalityCode);
    setState(() {
      languageCode = locale.languageCode;
      municipalityId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return languageCode == null || municipalityId == null
        ? const Center(child: CircularProgressIndicator())
        : Query(
            options: QueryOptions(
                document: gql(GraphQLQueries.barcodeMaterialQuery),
                variables: {
                  "languageCode": languageCode,
                  "municipalityId": municipalityId,
                }),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) return Text(result.exception.toString());
              if (result.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              // get barcode materials
              List<dynamic> barcodeMaterialData =
                  result.data?["getBarcodeMaterials"];
              Map<int, BarcodeMaterial> barcodeMaterials = {};
              for (dynamic element in barcodeMaterialData) {
                String categoryId =
                    element["barcode_material_id"]["category_id"]["objectId"];
                BarcodeMaterial material = BarcodeMaterial(
                    element["title"],
                    element["barcode_material_id"]["binary_value"],
                    DataHolder.categoriesById[categoryId]!);
                barcodeMaterials[material.binaryValue] = material;
              }

              Item? item = BarcodeResult.getItemFromBarcodeInfo(
                  widget.responseBody, barcodeMaterials);

              // api has no data for this barcode
              if (item == null) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title:
                          Text(Languages.of(context)!.barcodeAlertDialogTitle),
                      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                      content: Text(
                          Languages.of(context)!.barcodeAlertDialogExplanation),
                      actionsPadding:
                          const EdgeInsets.symmetric(horizontal: 24),
                      actions: [
                        TextButton(
                          child: Text(Languages.of(context)!
                              .barcodeAlertDialogButtonText),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  },
                );
                //TODO
                return const Center();
              }

              // item object successfully created with barcode info
              return Scaffold(
                appBar: AppBar(
                  title: Text(item.title),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.file(
                            File(item.wasteBin.imageFilePath),
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 2,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 30)),
                        Text.rich(TextSpan(
                            text:
                                Languages.of(context)!.itemDetailMaterialLabel,
                            style: Theme.of(context).textTheme.labelMedium,
                            children: [
                              TextSpan(
                                  text: item.material,
                                  style: Theme.of(context).textTheme.bodyText1)
                            ])),
                        const Padding(padding: EdgeInsets.only(bottom: 10)),
                        Text.rich(
                          TextSpan(
                            text:
                                Languages.of(context)!.itemDetailWasteBinLabel,
                            style: Theme.of(context).textTheme.labelMedium,
                            children: [
                              TextSpan(
                                  text: item.wasteBin.title,
                                  style: Theme.of(context).textTheme.bodyText1)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
