import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../../../i18n/languages.dart';
import '../../../util/database_classes/user.dart';
import '../../../util/graphl_ql_queries.dart';

class OverviewTile extends StatefulWidget {
  const OverviewTile({Key? key}) : super(key: key);

  @override
  State<OverviewTile> createState() => _OverviewTileState();
}

class _OverviewTileState extends State<OverviewTile> {

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
    return Consumer<User>(
      builder: (BuildContext context, User user, child) {
        return Query(
          options: QueryOptions(
            document: gql(GraphQLQueries.recentlyAndOftenSearchedItemQuery),
            variables: {"userId": user.currentUser?.objectId ?? ""},
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
      },
    );
  }
}
