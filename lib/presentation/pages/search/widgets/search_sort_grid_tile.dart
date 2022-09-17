import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

  void _addToSearchHistory() async{
    ParseUser? currentUser = await ParseUser.currentUser();
    if(currentUser != null){
      GraphQLClient client = GraphQLProvider.of(context).value;
      await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.networkOnly,
          document: gql(GraphQLQueries.searchHistoryMutation),
          variables: {
            "itemId": widget.item.objectId,
            "userId": currentUser.objectId,
            "selectedCategoryId": widget.category.objectId,
            "sortedCorrectly": widget.category == widget.item.wasteBin
          },
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
          CachedNetworkImage(
            imageUrl: widget.category.pictogramUrl,
            width: 100,
            height: 100,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Text(
            widget.category.title,
            style: Theme.of(context).textTheme.labelMedium,
          )
        ],
      ),
      onTap: () {
        _addToSearchHistory();
        AlertDialogWidget.showModal(
            context, widget.item, widget.isCorrect);
      },
    );
  }
}
