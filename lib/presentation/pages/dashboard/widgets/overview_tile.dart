import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../i18n/languages.dart';
import '../../../util/graphl_ql_queries.dart';

class OverviewTile extends StatefulWidget {
  const OverviewTile({Key? key}) : super(key: key);

  @override
  State<OverviewTile> createState() => _OverviewTileState();
}

class _OverviewTileState extends State<OverviewTile> {
  String userId = "";

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    ParseUser? current = await ParseUser.currentUser();
    setState(() {
      userId = current?.objectId ?? "";
    });
  }

  Widget _richText(int amount, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Text.rich(
        TextSpan(
          text: amount.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          children: <TextSpan>[
            TextSpan(text: text, style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(GraphQLQueries.recentlyAndOftenSearchedItemQuery),
        variables: {"userId": userId},
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) return Text(result.exception.toString());
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // get municipalities for selection
        int amountOfSearchedItems = result.data?["amountOfSearchedItems"] ?? 0;
        int amountOfRescuedItems = result.data?["amountOfRescuedItems"] ?? 0;

        // display when all data is available
        return Flexible(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Text(
                    Languages.of(context)!.overviewTileTitle,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
              _richText(
                amountOfSearchedItems,
                Languages.of(context)!.overviewTileRecycledText,
              ),
              _richText(
                amountOfRescuedItems,
                Languages.of(context)!.overviewTileSavedText,
              ),
            ],
          ),
        );
      },
    );
  }
}
