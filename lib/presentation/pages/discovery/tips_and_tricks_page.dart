import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/tips/tip_filter_dropdown.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/tips/tip_tile.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';
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
  Map<String, Tip> tipList = {};
  List<Tip> filteredTipList = [];
  Map<String, String> tipTypeOptions = {};
  Map<String, String> wasteBinOptions = {};
  String? filterTipTypeId;
  String? filterCategoryId;
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

  void _filterTips(String selected, bool isWasteBinFilter) {
    if (isWasteBinFilter) {
      filterCategoryId =
          selected != Languages.of(context)!.defaultCategoryDropdownItem
              ? wasteBinOptions[selected]
              : null;
    } else {
      filterTipTypeId =
          selected != Languages.of(context)!.defaultTipTypeDropdownItem
              ? tipTypeOptions[selected]
              : null;
    }

    List<Tip> filtered;
    if (filterCategoryId == null && filterTipTypeId == null) {
      // no filter set, show all tips
      filtered = tipList.values.toList();
    } else if (filterTipTypeId == null && filterCategoryId != null) {
      // only category filter set
      filtered = tipList.values
          .where((tip) => tip.subcategories
              .map((e) => e.parentId)
              .contains(filterCategoryId))
          .toList();
    } else if (filterTipTypeId != null && filterCategoryId == null) {
      // only type filter set
      filtered = tipList.values
          .where((tip) => tip.tipTypeId == filterTipTypeId)
          .toList();
    } else {
      // both filter set
      filtered = tipList.values
          .where((tip) =>
              tip.tipTypeId == filterTipTypeId &&
              tip.subcategories
                  .map((e) => e.parentId)
                  .contains(filterCategoryId))
          .toList();
    }

    setState(() {
      filteredTipList = filtered;
    });
  }

  Widget _getWidget() {
    for (Tip tip in filteredTipList) {
      tip.subcategories.map((cat) => DataHolder.categoriesById[cat.parentId]!.title).toSet();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TipFilterDropdown(
                filterOptions: wasteBinOptions.keys.toList(),
                defaultFilterValue:
                    Languages.of(context)!.defaultCategoryDropdownItem,
                isWasteBinType: true,
                filterTipList: _filterTips,
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 10)),
            Expanded(
              child: TipFilterDropdown(
                filterOptions: tipTypeOptions.keys.toList(),
                defaultFilterValue:
                    Languages.of(context)!.defaultTipTypeDropdownItem,
                isWasteBinType: false,
                filterTipList: _filterTips,
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Expanded(
          child: filteredTipList.isEmpty
              ? Center(child: Text(Languages.of(context)!.emptyListText))
              : ListView(
                  shrinkWrap: true,
                  children: [
                    ...filteredTipList.map((tip) {
                      return TipTile(
                        tip: tip,
                        tipTypeTag: tipTypeOptions.entries
                            .firstWhere(
                                (element) => element.value == tip.tipTypeId)
                            .key,
                        wasteBinTags: [
                          ...tip.subcategories.map((cat) =>
                          DataHolder.categoriesById[cat.parentId]!.title).toSet()
                        ],
                      );
                    }),
                  ],
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.tipsAndTricksTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.pagePadding),
        child: wasteBinOptions.isNotEmpty && tipTypeOptions.isNotEmpty
            ? _getWidget()
            : languageCode == null || userId == null
                ? const Center(child: CircularProgressIndicator())
                : Query(
                    options: QueryOptions(
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

                      //set tips
                      List<dynamic> tipData = result.data?["getTips"];
                      for (dynamic element in tipData) {
                        tipList[element["tip_id"]["objectId"]] =
                            Tip.fromGraphQlData(element);
                      }
                      filteredTipList = tipList.values.toList();

                      // set bookmarks
                      List<dynamic> tipBookmarkData =
                          result.data?["getTipBookmarks"];
                      for (dynamic element in tipBookmarkData) {
                        tipList[element["tip_id"]["objectId"]]?.isBookmarked =
                            true;
                      }

                      // set tip types
                      List<dynamic> tipTypeData = result.data?["getTipTypes"];
                      tipTypeOptions[Languages.of(context)!
                          .defaultTipTypeDropdownItem] = "default";
                      for (dynamic element in tipTypeData) {
                        tipTypeOptions[element["title"]] =
                            element["tip_type_id"]["objectId"];
                      }

                      // add subcategories to tips
                      List<dynamic> tipSubcategoryData =
                          result.data?["getTipSubcategories"];
                      for (dynamic element in tipSubcategoryData) {
                        Tip tip = tipList[element["tip_id"]["objectId"]]!;
                        Subcategory subcategory = DataHolder.subcategoriesById[
                            element["subcategory_id"]["objectId"]]!;
                        tip.subcategories.add(subcategory);
                      }

                      // set waste bin types
                      for (MapEntry<String, WasteBinCategory> entry
                          in DataHolder.categoriesById.entries) {
                        wasteBinOptions[entry.value.title] = entry.key;
                      }
                      wasteBinOptions[Languages.of(context)!
                          .defaultCategoryDropdownItem] = "default";

                      return _getWidget();
                    },
                  ),
      ),
    );
  }
}
