import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/util/database_classes/barcode_material.dart';
import 'package:recycling_app/presentation/util/database_classes/item.dart';

import '../../../i18n/languages.dart';
import '../../../i18n/locale_constant.dart';
import '../../../util/BarcodeResult.dart';
import '../../../util/data_holder.dart';
import '../../../util/graphl_ql_queries.dart';

class BasicItemDetailWidget extends StatefulWidget {
  const BasicItemDetailWidget({Key? key, required this.responseBody})
      : super(key: key);

  final String responseBody;

  @override
  State<BasicItemDetailWidget> createState() => _BasicItemDetailWidgetState();
}

class _BasicItemDetailWidgetState extends State<BasicItemDetailWidget> {
  String languageCode = "";
  bool isBookmarked = false;

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
        isBookmarked = item.bookmarked;
        return Scaffold(
          appBar: AppBar(
            title: Text(item.title),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isBookmarked = !isBookmarked;
                      //TODO: update DB
                    });
                  },
                  icon: isBookmarked
                      ? const Icon(FontAwesomeIcons.solidBookmark)
                      : const Icon(FontAwesomeIcons.bookmark))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SvgPicture.network(
                      item.wasteBin.pictogramUrl,
                      color: item.wasteBin.color,
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  Text(
                      Languages.of(context)!.itemDetailMaterialLabel +
                          item.material,
                      style: Theme.of(context).textTheme.bodyText1),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  Text(
                      Languages.of(context)!.itemDetailWasteBinLabel +
                          item.wasteBin.title,
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
