import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/tip_page.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/tip_tile.dart';

import '../../i18n/locale_constant.dart';
import '../../util/constants.dart';
import '../../util/tip.dart';

class TipsAndTricksPage extends StatefulWidget {
  const TipsAndTricksPage({Key? key}) : super(key: key);

  @override
  State<TipsAndTricksPage> createState() => _TipsAndTricksPageState();
}

//TODO: add bookmarked
class _TipsAndTricksPageState extends State<TipsAndTricksPage> {
  Map<String, String> wasteBinDropdownOptions = {};
  Map<String, String> tipTypeDropdownOptions = {};
  String? wasteBinDefault;
  String? tipTypeDefault;
  List<Tip> tipList = [];
  String languageCode = "";
  String queryCategories = """
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
  String queryTipTypes = """
    query GetTipTypes(\$languageCode: String!){
      getTipTypes(languageCode: \$languageCode){
        title
        tip_type_id{
          color
          objectId
        }
      }
    }
  """;
  String queryTips = """
    query GetTips(\$languageCode: String!){
      getTips(languageCode: \$languageCode){
        tip_id{
    	    category_id{
    	      objectId
      	    pictogram
    	    },
    	    tip_type_id{
    	      objectId
      	    color
    	    },
  	    }, 
        title,
        explanation,
        short
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

  void _setFilterValuesToDefault() {
    setState(() {
      wasteBinDefault = Languages.of(context)!.defaultDropdownItem;
      tipTypeDefault = Languages.of(context)!.defaultDropdownItem;
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
                Query(
                  options: QueryOptions(
                      document: gql(queryCategories),
                      variables: {"languageCode": languageCode}),
                  builder: (QueryResult result,
                      {VoidCallback? refetch, FetchMore? fetchMore}) {
                    if (result.hasException) return Text(result.exception.toString());
                    if (result.isLoading) return const Text('Loading');

                    List<dynamic> categories = result.data?["getCategories"];

                    if (categories.isEmpty) {
                      return const Text("No tips found.");
                    }

                    // set dropdown default and map of all categories
                    wasteBinDefault =
                        Languages.of(context)!.defaultDropdownItem;
                    wasteBinDropdownOptions["default"] = wasteBinDefault!;
                    for (dynamic element in categories) {
                      wasteBinDropdownOptions[element["category_id"]
                          ["objectId"]] = element["title"];
                    }

                    // display when all data is available
                    return Expanded(
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
                                  items: wasteBinDropdownOptions.values
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Query(
                  options: QueryOptions(
                      document: gql(queryTipTypes),
                      variables: {"languageCode": languageCode}),
                  builder: (QueryResult result,
                      {VoidCallback? refetch, FetchMore? fetchMore}) {
                    if (result.hasException) return Text(result.exception.toString());
                    if (result.isLoading) return const Text('Loading');

                    List<dynamic> tipTypes = result.data?["getTipTypes"];

                    if (tipTypes.isEmpty) {
                      return const Text("No tips found.");
                    }

                    // set dropdown default and map of all categories
                    tipTypeDefault = Languages.of(context)!.defaultDropdownItem;
                    tipTypeDropdownOptions["default"] = tipTypeDefault!;
                    for (dynamic element in tipTypes) {
                      tipTypeDropdownOptions[element["tip_type_id"]
                          ["objectId"]] = element["title"];
                    }
                    // display when all data is available
                    return Expanded(
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
                            items: tipTypeDropdownOptions.values
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                GestureDetector(
                  child: const Icon(FontAwesomeIcons.xmark),
                  onTap: () => {_setFilterValuesToDefault()},
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Query(
              options: QueryOptions(
                  document: gql(queryTips),
                  variables: {"languageCode": languageCode}),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) return Text(result.exception.toString());
                if (result.isLoading) return const Text('Loading');

                List<dynamic> tips = result.data?["getTips"];

                if (tips.isEmpty) {
                  return const Text("No tips found.");
                }

                // det dropdown default and map of all categories
                for (dynamic element in tips) {
                  //TODO better way to do this?
                  if(!tipList.any((tip) => tip.title == element["title"])) {
                    tipList.add(Tip(
                        element["title"],
                        element["explanation"],
                        element["short"],
                        element["tip_id"]["tip_type_id"]["objectId"],
                        element["tip_id"]["category_id"]["objectId"]));
                  }
                }

                // display when all data is available
                return Expanded(
                  child: ListView(
                    children: [
                      ...tipList.map((tip) {
                        return TipTile(
                          title: tip.title,
                          destinationPage: TipPage(tipTitle: tip.title),
                          tags: [
                            tipTypeDropdownOptions[tip.tipTypeId] ?? "",
                            wasteBinDropdownOptions[tip.categoryId] ?? "",
                          ],
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
