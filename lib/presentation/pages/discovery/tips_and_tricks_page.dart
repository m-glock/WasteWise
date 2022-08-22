import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
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
  List<Tip> filteredTipList = [];
  String languageCode = "";
  String query = """
    query GetCategories(\$languageCode: String!, \$municipalityId: String!){
      getCategories(languageCode: \$languageCode, municipalityId: \$municipalityId){
        title
        category_id{
          objectId
          image_file{
            url
          }
          hex_color
        }
      }
      
      getTipTypes(languageCode: \$languageCode){
        title
        tip_type_id{
          color
          objectId
        }
      }
      
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
    	    image{
    	      url
    	    }
  	    }, 
        title,
        explanation
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
      filteredTipList = tipList;
    });
  }

  void _applyTipTypeFilter(String newValue) {
    tipTypeDefault = newValue;
    String tipTypeId = tipTypeDropdownOptions.keys
        .where((key) => tipTypeDropdownOptions[key] == newValue)
        .first;
    if (tipTypeDefault == Languages.of(context)!.defaultDropdownItem) {
      filteredTipList =
          tipList.where((tip) => tip.tipTypeId == tipTypeId).toList();
    } else {
      filteredTipList =
          filteredTipList.where((tip) => tip.tipTypeId == tipTypeId).toList();
    }
  }

  void _applyCategoryFilter(String newValue) {
    wasteBinDefault = newValue;
    String wasteBinId = wasteBinDropdownOptions.keys
        .where((key) => wasteBinDropdownOptions[key] == newValue)
        .first;
    if (tipTypeDefault == Languages.of(context)!.defaultDropdownItem) {
      filteredTipList =
          tipList.where((tip) => tip.categoryId == wasteBinId).toList();
    } else {
      filteredTipList =
          filteredTipList.where((tip) => tip.categoryId == wasteBinId).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.tipsAndTricksTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.pagePadding),
        child: Query(
          options: QueryOptions(document: gql(query), variables: {
            "languageCode": languageCode,
            "municipalityId": "PMJEteBu4m" //TODO get from user
          }),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) return Text(result.exception.toString());
            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // set dropdown default values
            String defaultDropdownItem =
                Languages.of(context)!.defaultDropdownItem;
            wasteBinDefault ??= defaultDropdownItem;
            tipTypeDefault ??= defaultDropdownItem;
            wasteBinDropdownOptions["default"] ??= defaultDropdownItem;
            tipTypeDropdownOptions["default"] ??= defaultDropdownItem;

            // get data
            List<dynamic> categories = result.data?["getCategories"];
            List<dynamic> tipTypes = result.data?["getTipTypes"];
            List<dynamic> tips = result.data?["getTips"];

            // set waste bin types
            for (dynamic category in categories) {
              wasteBinDropdownOptions[category["category_id"]["objectId"]] =
                  category["title"];
            }

            // set tip types
            for (dynamic element in tipTypes) {
              tipTypeDropdownOptions[element["tip_type_id"]["objectId"]] =
                  element["title"];
            }

            //set tips
            for (dynamic element in tips) {
              //TODO better way to do this?
              if (!tipList.any((tip) => tip.title == element["title"])) {
                tipList.add(Tip(
                    element["title"],
                    element["explanation"],
                    element["tip_id"]["tip_type_id"]["objectId"],
                    element["tip_id"]["category_id"]["objectId"],
                    element["tip_id"]["image"]["url"]));
              }
            }

            if (filteredTipList.isEmpty &&
                tipTypeDefault == defaultDropdownItem &&
                tipTypeDefault == defaultDropdownItem) {
              filteredTipList = tipList;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
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
                                      _applyCategoryFilter(newValue!);
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
                    ),
                    const Padding(padding: EdgeInsets.only(right: 10)),
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
                                _applyTipTypeFilter(newValue!);
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
                    ),
                    const Padding(padding: EdgeInsets.only(right: 10)),
                    GestureDetector(
                      child: const Icon(FontAwesomeIcons.xmark),
                      onTap: () => {_setFilterValuesToDefault()},
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Expanded(
                  child: filteredTipList.isEmpty
                      ? Center(
                          child: Text(Languages.of(context)!.emptyListText))
                      : ListView(
                          children: [
                            ...filteredTipList.map((tip) {
                              return TipTile(
                                tip: tip,
                                tags: [
                                  tipTypeDropdownOptions[tip.tipTypeId] ?? "",
                                  wasteBinDropdownOptions[tip.categoryId] ?? "",
                                ],
                              );
                            }),
                          ],
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
