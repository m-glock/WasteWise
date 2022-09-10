import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/locale_constant.dart';
import 'package:recycling_app/presentation/pages/discovery/tip_detail_page.dart';
import 'package:recycling_app/presentation/util/custom_icon_button.dart';

import '../../../i18n/languages.dart';
import '../../../util/constants.dart';
import '../../../util/database_classes/item.dart';
import '../../../util/database_classes/tip.dart';
import '../../../util/graphl_ql_queries.dart';
import '../../search/item_detail_page.dart';

class BookmarkedTile extends StatefulWidget {
  const BookmarkedTile({
    Key? key,
    required this.title,
    required this.objectId,
    required this.isItem,
    required this.removeBookmarkInParent,
  }) : super(key: key);

  final String title;
  final String objectId;
  final bool isItem;
  final void Function(String, bool) removeBookmarkInParent;

  @override
  State<BookmarkedTile> createState() => _BookmarkedTileState();
}

class _BookmarkedTileState extends State<BookmarkedTile> {

  void _openItemDetailPage() async {
    Locale locale = await getLocale();
    Map<String, dynamic> inputVariables = {
      "languageCode": locale.languageCode,
      "itemObjectId": widget.objectId,
      "userId": (await ParseUser.currentUser()).objectId!,
    };

    GraphQLClient client = GraphQLProvider
        .of(context)
        .value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(GraphQLQueries.itemDetailQuery),
        variables: inputVariables,
      ),
    );

    Item? item = Item.fromJson(result.data);
    if(item == null) throw Exception("No item found.");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          ItemDetailPage(
            item: item, updateBookmarkInParent: _updateBookmarkForWidget),
      ),
    );
  }

  void _openTipDetailPage() async {
    Locale locale = await getLocale();
    Map<String, dynamic> inputVariables = {
      "languageCode": locale.languageCode,
      "tipId": widget.objectId,
    };

    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(GraphQLQueries.tipDetailQuery),
        variables: inputVariables,
      ),
    );

    Tip tip = Tip.fromJson(result.data?["getTip"], bookmarked: true);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          TipDetailPage(
            tip: tip,
            tipNumber: 1, //TODO?
            updateBookmarkInParent: _updateBookmarkForWidget,
          )),
    );
  }

  void _updateBookmarkForWidget() {
    widget.removeBookmarkInParent(
      widget.objectId,
      widget.isItem,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .colorScheme
            .surface,
        borderRadius: Constants.tileBorderRadius,
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                if (widget.isItem) {
                  _openItemDetailPage();
                } else {
                  _openTipDetailPage();
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconButton(
                    icon: const Icon(FontAwesomeIcons.solidBookmark),
                    onPressed: () =>
                        widget.removeBookmarkInParent(
                          widget.objectId,
                          widget.isItem,
                        ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline3,
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 5)),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 12),
                          child: Text(
                            widget.isItem
                                ? Languages.of(context)!.itemBookmarkTagTitle
                                : Languages.of(context)!.tipBookmarkTagTitle,
                            style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onSecondary),
                          ),
                          decoration: BoxDecoration(
                            color: widget.isItem
                                ? Theme
                                .of(context)
                                .colorScheme
                                .secondary
                                : Theme
                                .of(context)
                                .colorScheme
                                .tertiary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  const Icon(FontAwesomeIcons.angleRight),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
