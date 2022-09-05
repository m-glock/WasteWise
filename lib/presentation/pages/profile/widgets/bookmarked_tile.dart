import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/i18n/locale_constant.dart';
import 'package:recycling_app/presentation/util/custom_icon_button.dart';

import '../../../util/constants.dart';
import '../../../util/database_classes/item.dart';
import '../../../util/graphl_ql_queries.dart';
import '../../search/item_detail_page.dart';

class BookmarkedTile extends StatefulWidget {
  const BookmarkedTile({
    Key? key,
    required this.title,
    required this.objectId,
    required this.isItem,
  }) : super(key: key);

  final String title;
  final String objectId;
  final bool isItem;

  @override
  State<BookmarkedTile> createState() => _BookmarkedTileState();
}

class _BookmarkedTileState extends State<BookmarkedTile> {
  void _openItemDetailPage() async {
    Locale locale = await getLocale();
    Map<String, dynamic> inputVariables = {
      "languageCode": locale.languageCode,
      "itemObjectId": widget.objectId
    };

    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(GraphQLQueries.itemDetailQuery),
        variables: inputVariables,
      ),
    );

    Item item = Item.fromJson(
        result.data?["getItem"][0], result.data?["getSubcategoryOfItem"][0]);
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
                //TODO item or tip?
                _openItemDetailPage();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconButton(
                    icon: const Icon(FontAwesomeIcons.solidBookmark),
                    onPressed: () {
                      //TODO: remove bookmark in DB and item from list
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headline3,
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
