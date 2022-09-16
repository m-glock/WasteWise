import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/tips/tip_tile.dart';
import 'package:recycling_app/presentation/util/custom_icon_button.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';
import 'package:recycling_app/presentation/util/graphl_ql_queries.dart';

import '../../i18n/locale_constant.dart';
import '../../util/constants.dart';
import '../../util/database_classes/subcategory.dart';
import '../../util/database_classes/tip.dart';

class TipsAndTricksPage extends StatefulWidget {
  const TipsAndTricksPage({Key? key}) : super(key: key);

  @override
  State<TipsAndTricksPage> createState() => _TipsAndTricksPageState();
}

class _TipsAndTricksPageState extends State<TipsAndTricksPage> {
  Map<String, String> wasteBinDropdownOptions = {};
  Map<String, String> tipTypeDropdownOptions = {};
  String? wasteBinDefault;
  String? tipTypeDefault;
  Map<String, Tip> tipList = {};
  List<Tip> filteredTipList = [];
  String? languageCode;
  String? userId;

  @override
  void initState() {
    super.initState();
    _getLanguageCodeAndUserId();
  }

  void _getLanguageCodeAndUserId() async {
    Locale locale = await getLocale();
    ParseUser? current = await ParseUser.currentUser();
    setState(() {
      languageCode = locale.languageCode;
      userId = current?.objectId ?? "";
    });
  }

  void _setFilterValuesToDefault() {
    setState(() {
      wasteBinDefault = Languages.of(context)!.defaultDropdownItem;
      tipTypeDefault = Languages.of(context)!.defaultDropdownItem;
      filteredTipList = tipList.values.toList();
    });
  }

  void _applyTipTypeFilter(String newValue) {
    tipTypeDefault = newValue;
    String tipTypeId = tipTypeDropdownOptions.keys
        .where((key) => tipTypeDropdownOptions[key] == newValue)
        .first;
    if (tipTypeDefault == Languages.of(context)!.defaultDropdownItem) {
      filteredTipList =
          tipList.values.where((tip) => tip.tipTypeId == tipTypeId).toList();
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
      filteredTipList = tipList.values
          .where((tip) => tip.subcategories
              .any((subcategory) => subcategory.parentId == wasteBinId))
          .toList();
    } else {
      filteredTipList = filteredTipList
          .where((tip) => tip.subcategories
              .any((subcategory) => subcategory.parentId == wasteBinId))
          .toList();
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
        child: languageCode == null || userId == null
            ? const Center(child: CircularProgressIndicator())
            : Query(
                options: QueryOptions(
                    fetchPolicy: FetchPolicy.networkOnly,
                    document: gql(GraphQLQueries.tipListQuery),
                    variables: {
                      "languageCode": languageCode,
                      "userId": userId
                    }),
                builder: (QueryResult result,
                    {VoidCallback? refetch, FetchMore? fetchMore}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }
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
                  List<dynamic> tipTypes = result.data?["getTipTypes"];
                  List<dynamic> tips = result.data?["getTips"];
                  List<dynamic> tipBookmarks = result.data?["getTipBookmarks"];
                  List<dynamic> tipSubcategories =
                      result.data?["getTipSubcategories"];

                  // set tip types
                  for (dynamic element in tipTypes) {
                    tipTypeDropdownOptions[element["tip_type_id"]["objectId"]] =
                        element["title"];
                  }

                  //set tips
                  for (dynamic element in tips) {
                    tipList[element["tip_id"]["objectId"]] =
                        Tip.fromJson(element);
                  }

                  // set waste bin types
                  for (dynamic element in tipSubcategories) {
                    Tip? tip = tipList[element["tip_id"]["objectId"]];
                    Subcategory? subcategory = DataHolder.subcategoriesById[
                        element["subcategory_id"]["objectId"]];
                    if (subcategory != null) {
                      tip?.subcategories.add(subcategory);
                    }
                  }

                  // set bookmarks
                  for (dynamic element in tipBookmarks) {
                    tipList[element["tip_id"]["objectId"]]?.isBookmarked = true;
                  }

                  if (filteredTipList.isEmpty &&
                      tipTypeDefault == defaultDropdownItem &&
                      tipTypeDefault == defaultDropdownItem) {
                    filteredTipList = tipList.values.toList();
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
                                Text(Languages.of(context)!
                                    .dropdownWasteBinLabel),
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
                                Text(Languages.of(context)!
                                    .dropdownTipTypeLabel),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  value: tipTypeDefault,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _applyTipTypeFilter(newValue!);
                                    });
                                  },
                                  items: tipTypeDropdownOptions.values
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          CustomIconButton(
                            padding: const EdgeInsets.only(right: 10),
                            onPressed: _setFilterValuesToDefault,
                            icon: const Icon(FontAwesomeIcons.xmark),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                      Expanded(
                        child: filteredTipList.isEmpty
                            ? Center(
                                child:
                                    Text(Languages.of(context)!.emptyListText))
                            : ListView(
                                children: [
                                  ...filteredTipList.map((tip) {
                                    return TipTile(
                                      tip: tip,
                                      tags: [
                                        tipTypeDropdownOptions[tip.tipTypeId] ??
                                            "",
                                        ...tip.subcategories.map((cat) =>
                                            DataHolder.categoriesById[cat.parentId]!
                                                .title)
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
