import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/search/widgets/item_detail_tile.dart';
import 'package:recycling_app/presentation/util/graphl_ql_queries.dart';

import '../../i18n/locale_constant.dart';
import '../../util/database_classes/item.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage(
      {Key? key, required this.objectId})
      : super(key: key);

  final String objectId;

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

//TODO: figure out how to access category name (TL)
class _ItemDetailPageState extends State<ItemDetailPage> {
  bool isBookmarked = false;
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
          //TODO: check if still necessary after figuring cache out
          fetchPolicy: FetchPolicy.networkOnly,
          document: gql(GraphQLQueries.itemDetailQuery),
          variables: {
            "languageCode": languageCode,
            "itemObjectId": widget.objectId,
          }),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) return Text(result.exception.toString());
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        List<dynamic> items = result.data?["getItem"];
        List<dynamic> subcategory = result.data?["getSubcategoryOfItem"];

        if (items.isEmpty) {
          Navigator.pop(context);
          //TODO: let user know whats wrong
          return const Text("No item found.");
        }

        Item item = Item.fromJson(items[0], subcategory[0]);

        // display when all data is available
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
                  Text(Languages.of(context)!.itemDetailMaterialLabel + item.material,
                      style: Theme.of(context).textTheme.bodyText1),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  Text(Languages.of(context)!.itemDetailWasteBinLabel + item.wasteBin.title,
                      style: Theme.of(context).textTheme.bodyText1),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  Text(Languages.of(context)!.itemDetailMoreInfoLabel + item.subcategory,
                      style: Theme.of(context).textTheme.bodyText1),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  ItemDetailTile(
                      headerTitle: Languages.of(context)!.itemDetailExplanationLabel,
                      expandedText: item.explanation
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  //TODO: get tips and preventions
                  ItemDetailTile(
                      headerTitle: Languages.of(context)!.itemDetailTipsLabel,
                      expandedText: item.explanation
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  ItemDetailTile(
                      headerTitle: Languages.of(context)!.itemDetailPreventionLabel,
                      expandedText: item.explanation
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
