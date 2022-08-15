import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/waste_bin_detail_page.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/discovery_tile.dart';
import 'package:recycling_app/presentation/util/hex_color.dart';
import 'package:recycling_app/presentation/util/waste_bin_category.dart';

import '../../i18n/locale_constant.dart';
import '../../util/constants.dart';

class WasteBinOverviewPage extends StatefulWidget {
  const WasteBinOverviewPage({Key? key}) : super(key: key);

  @override
  State<WasteBinOverviewPage> createState() => _WasteBinOverviewPageState();
}

class _WasteBinOverviewPageState extends State<WasteBinOverviewPage> {
  String languageCode = "";
  String query = """
    query GetCategories(\$languageCode: String!){
      getCategories(languageCode: \$languageCode){
        title
        category_id{
          objectId
          image_file{
            url
          }
          hex_color
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
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.wasteBinOverviewTitle),
      ),
      body: Query(
        options: QueryOptions(
            document: gql(query), variables: {"languageCode": languageCode}),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) return Text(result.exception.toString());
          if (result.isLoading) return const Text('Loading');

          List<dynamic> categories = result.data?["getCategories"];

          if (categories.isEmpty) {
            return const Text("No tips found.");
          }

          List<WasteBinCategory> wasteBinCategories = [];
          for (dynamic element in categories) {
            wasteBinCategories.add(WasteBinCategory(
                element["title"],
                element["category_id"]["objectId"],
                HexColor.fromHex(element["category_id"]["hex_color"]),
                element["category_id"]["image_file"]["url"]));
          }

          // display when all data is available
          return Padding(
            padding: EdgeInsets.all(Constants.pagePadding),
            child: ListView(
              children: [
                ...wasteBinCategories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DiscoveryTile(
                      leading: SvgPicture.network(
                        category.pictogramUrl,
                        width: 50,
                        height: 50,
                        color: category.color,
                      ),
                      title: category.title,
                      subtitle: null,
                      destinationPage:
                          WasteBinDetailPage(wasteBinName: category.title),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
