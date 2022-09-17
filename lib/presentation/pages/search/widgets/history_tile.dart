import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/util/database_classes/search_history_item.dart';

import '../../../util/constants.dart';
import '../../../util/database_classes/item.dart';
import '../../../util/graphl_ql_queries.dart';
import '../../search/item_detail_page.dart';

class HistoryTile extends StatefulWidget {
  const HistoryTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SearchHistoryItem item;

  @override
  State<HistoryTile> createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  double pictogramSize = 30;

  String _getDateString(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  }

  void _openItemDetailPage() async {
    Locale locale = await getLocale();
    Map<String, dynamic> inputVariables = {
      "languageCode": locale.languageCode,
      "itemObjectId": widget.item.objectId,
      "userId": (await ParseUser.currentUser()).objectId!,
    };

    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(GraphQLQueries.itemDetailQuery),
        variables: inputVariables,
      ),
    );

    Item? item = Item.fromGraphQlData(result.data);
    if(item == null) throw Exception("No item found.");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ItemDetailPage(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Constants.tileBorderRadius,
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                _openItemDetailPage();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.title,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          _getDateString(widget.item.createdAt),
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  Expanded(
                    child: Row(
                      children: [
                        if (widget.item.selectedCategory !=
                            widget.item.correctWasteBin) ...[
                          Stack(
                            children: [
                              Container(
                                color: Colors.white,
                                width: pictogramSize,
                                height: pictogramSize,
                              ),
                              Image.file(
                                File(widget.item.selectedCategory.imageFilePath),
                                width: pictogramSize,
                                height: pictogramSize,
                                color: Colors.white.withOpacity(0.5),
                                colorBlendMode: BlendMode.modulate,
                              ),
                              SvgPicture.asset(
                                "assets/images/strikethrough.svg",
                                width: pictogramSize,
                                height: pictogramSize,
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(right: 10)),
                        ],
                        Stack(
                          children: [
                            Container(
                              color: Colors.white,
                              width: pictogramSize,
                              height: pictogramSize,
                            ),
                            Image.file(
                              File(widget.item.correctWasteBin.imageFilePath),
                              width: pictogramSize,
                              height: pictogramSize,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
