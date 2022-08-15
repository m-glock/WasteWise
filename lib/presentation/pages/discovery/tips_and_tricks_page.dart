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
        child: Query(
          options: QueryOptions(
              document: gql(query),
              variables: {"languageCode": languageCode}
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {

            //TODO execute all three queries somehow
            if (result.hasException) return Text(result.exception.toString());
            if (result.isLoading) return const Text('Loading');

            // set dropdown default values
            wasteBinDefault = Languages.of(context)!.defaultDropdownItem;
            tipTypeDefault = Languages.of(context)!.defaultDropdownItem;
            wasteBinDropdownOptions["default"] = wasteBinDefault!;
            tipTypeDropdownOptions["default"] = tipTypeDefault!;

            // get data
            List<dynamic> categories = result.data?["getCategories"];
            List<dynamic> tipTypes = result.data?["getTipTypes"];
            List<dynamic> tips = result.data?["getTips"];

            // set waste bin types
            for (dynamic category in categories) {
              wasteBinDropdownOptions[category["category_id"]["objectId"]]
                = category["title"];
            }

            // set tip types
            for (dynamic element in tipTypes) {
              tipTypeDropdownOptions[element["tip_type_id"]
              ["objectId"]] = element["title"];
            }

            //set tips
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
