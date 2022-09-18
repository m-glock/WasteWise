import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/pages/search/widgets/barcode_item_warning_widget.dart';
import 'package:recycling_app/presentation/util/constants.dart';
import 'package:recycling_app/presentation/util/database_classes/barcode_material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../i18n/languages.dart';
import '../../i18n/locale_constant.dart';
import '../../util/BarcodeResult.dart';
import '../../util/data_holder.dart';
import '../../util/database_classes/barcode_item.dart';
import '../../util/graphl_ql_queries.dart';

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

              BarcodeItem item = BarcodeResult.getItemFromBarcodeInfo(
                  widget.responseBody, barcodeMaterials);

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
                        BarcodeItemWarningWidget(
                          errorText: Languages.of(context)!
                              .itemDetailBarcodeWarningText,
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10)),
                        Center(
                          child: Image.file(
                            File(item.wasteBin[0].imageFilePath),
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
                                  text: item.wasteBin
                                      .map((e) => e.title)
                                      .join(", "),
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
