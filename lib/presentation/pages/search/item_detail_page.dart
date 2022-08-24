import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/search/widgets/item_detail_tile.dart';
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';

import '../../i18n/locale_constant.dart';
import '../../util/hex_color.dart';
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
  String query = """
    query GetItem(\$languageCode: String!, \$objectId: String!){
      getItem(languageCode: \$languageCode, objectId: \$objectId){
        title
        explanation
        material
        item_id{
          subcategory_id{
            category_id{
              objectId
        	    hex_color
        	    image_file{
                url
              }  
      	    }
          }
        }
      }
    }
  """;

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
          document: gql(query),
          variables: {
            "languageCode": languageCode,
            "objectId": widget.objectId,
          }),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) return Text(result.exception.toString());
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        List<dynamic> items = result.data?["getItem"];

        if (items.isEmpty) {
          Navigator.pop(context);
          //TODO: let user know whats wrong
          return const Text("No tips found.");
        }

        dynamic category = items[0]["item_id"]["subcategory_id"]["category_id"];
        WasteBinCategory wasteBin = WasteBinCategory(
            "Unknown",
            category["objectId"],
            HexColor.fromHex(category["hex_color"]),
            category["image_file"]["url"]);
        //TODO: set isBookmarked of item, explanation, and subcategory
        Item item = Item(
            items[0]["title"],
            //items[0]["explanation"],
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                "Aliquam in augue varius ligula volutpat aliquet. "
                "Quisque eget hendrerit ante. Donec hendrerit bibendum"
                " risus, a malesuada turpis interdum eu. Integer ut "
                "varius lorem, non pretium urna. Etiam nisi ligula, "
                "gravida at velit sed, commodo mollis justo. Aenean "
                "risus felis, tincidunt ac nunc nec, placerat sodales "
                "leo. Integer vel volutpat ex, ac porttitor augue. In "
                "dignissim lobortis urna eu mollis. Mauris scelerisque"
                " nec tellus sed euismod. ",
            items[0]["material"],
            "Subcategory",
            wasteBin);

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
                  ItemDetailTile(
                      headerTitle: Languages.of(context)!.itemDetailTipsLabel,
                      expandedText: item.explanation //TODO
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  ItemDetailTile(
                      headerTitle: Languages.of(context)!.itemDetailPreventionLabel,
                      expandedText: item.explanation //TODO
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
