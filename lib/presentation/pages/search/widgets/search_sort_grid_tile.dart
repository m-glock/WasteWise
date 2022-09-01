import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/pages/search/widgets/alert_dialog_widget.dart';
import 'package:recycling_app/presentation/util/database_classes/item.dart';
import 'package:recycling_app/presentation/util/graphl_ql_queries.dart';

import '../../../util/database_classes/waste_bin_category.dart';

class SearchSortGridTile extends StatefulWidget {
  const SearchSortGridTile(
      {Key? key,
      required this.category,
      required this.isCorrect,
      required this.item})
      : super(key: key);

  final WasteBinCategory category;
  final bool isCorrect;
  final Item item;

  @override
  State<SearchSortGridTile> createState() => _SearchSortGridTileState();
}

class _SearchSortGridTileState extends State<SearchSortGridTile> {
  void _updateItemBookmarked() {
    //TODO: update in DB
  }

  void _addToSearchHistory() async{
    ParseUser? currentUser = await ParseUser.currentUser();
    if(currentUser != null){
      dynamic inputVariables = GraphQLQueries.getInputVariablesForSearchHistory(
          currentUser.objectId!,
          widget.item.objectId,
          widget.category.objectId
      );

      GraphQLClient client = GraphQLProvider.of(context).value;
      await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.networkOnly,
          document: gql(GraphQLQueries.searchHistoryMutation),
          variables: inputVariables,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.network(
            widget.category.pictogramUrl,
            color: widget.category.color,
            width: 100,
            height: 100,
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Text(
            widget.category.title,
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
      onTap: () {
        _addToSearchHistory();
        AlertDialogWidget.showModal(
            context, widget.item, widget.isCorrect, _updateItemBookmarked);
      },
    );
  }
}
