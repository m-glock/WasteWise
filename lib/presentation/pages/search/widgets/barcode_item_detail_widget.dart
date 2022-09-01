import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/pages/search/widgets/item_detail_widget.dart';
import 'package:recycling_app/presentation/util/database_classes/barcode_material.dart';
import 'package:recycling_app/presentation/util/database_classes/item.dart';

import '../../../i18n/languages.dart';
import '../../../i18n/locale_constant.dart';
import '../../../util/BarcodeResult.dart';
import '../../../util/data_holder.dart';
import '../../../util/graphl_ql_queries.dart';

class BarcodeItemDetailWidget extends StatefulWidget {
  const BarcodeItemDetailWidget({Key? key, required this.responseBody})
      : super(key: key);

  final String responseBody;

  @override
  State<BarcodeItemDetailWidget> createState() => _BarcodeItemDetailWidgetState();
}

class _BarcodeItemDetailWidgetState extends State<BarcodeItemDetailWidget> {
  String languageCode = "";

  @override
  void initState() {
    super.initState();
    _getLanguageCode();
  }

  void _getLanguageCode() async {
    Locale locale = await getLocale();
    setState(() {
      languageCode = locale.languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(GraphQLQueries.barcodeMaterialQuery),
          variables: {
            "languageCode": languageCode,
            "municipalityId": "PMJEteBu4m", //TODO get from user
          }),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) return Text(result.exception.toString());
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // get barcode materials
        List<dynamic> barcodeMaterialData = result.data?["getBarcodeMaterials"];
        Map<int, BarcodeMaterial> barcodeMaterials = {};
        for (dynamic element in barcodeMaterialData) {
          BarcodeMaterial material = BarcodeMaterial(
              element["title"],
              element["barcode_material_id"]["binary_value"],
              DataHolder.categories.firstWhere((category) =>
                  element["barcode_material_id"]["category_id"]["objectId"] ==
                  category.objectId));
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
                title: Text(Languages.of(context)!.barcodeAlertDialogTitle),
                contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                content:
                    Text(Languages.of(context)!.barcodeAlertDialogExplanation),
                actionsPadding: const EdgeInsets.symmetric(horizontal: 24),
                actions: [
                  TextButton(
                    child: Text(
                        Languages.of(context)!.barcodeAlertDialogButtonText),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
          return const Center();
        }

        // item object successfully created with barcode info
        return ItemDetailWidget(item: item);
      },
    );
  }
}
