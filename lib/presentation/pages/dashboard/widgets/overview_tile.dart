import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../logic/data_holder.dart';
import '../../../../logic/util/user.dart';
import '../../../i18n/languages.dart';
import '../../../../logic/database_access/graphl_ql_queries.dart';

class OverviewTile extends StatefulWidget {
  const OverviewTile({Key? key}) : super(key: key);

  @override
  State<OverviewTile> createState() => _OverviewTileState();
}

class _OverviewTileState extends State<OverviewTile> {
  Widget _richText(int amount, String text) {
    return Text.rich(
      TextSpan(
        text: amount.toString(),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(text: text, style: Theme.of(context).textTheme.bodyText2),
        ],
      ),
    );
  }

  void _createForumPost(String userId, String savedItemNumber) async {
    String forumTypeId = DataHolder.forumEntryTypesById.entries
        .firstWhere((element) => element.value.typeName == "Progress")
        .key;
    Map<String, dynamic> inputVariables = {
      "userId": (userId),
      "forumEntryTypeId": forumTypeId,
      "text": savedItemNumber,
    };

    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(
        document: gql(GraphQLQueries.createForumPost),
        variables: inputVariables,
      ),
    );

    Map<String, dynamic>? forumEntryData = result.data?["createForumEntries"];

    String snackBarText = result.hasException || forumEntryData == null
        ? Languages.of(context)!.overviewShareUnsuccessful
        : Languages.of(context)!.overviewShareSuccessful;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(snackBarText)));
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
              return const Center();
            }

            // get municipalities for selection
            int amountOfSearchedItems =
                result.data?["amountOfSearchedItems"] ?? 0;
            int amountOfRescuedItems =
                result.data?["amountOfWronglySortedItems"] ?? 0;

            // display when all data is available
            return Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Expanded(
                    child: Column(
                      children: [
                        _richText(
                          amountOfSearchedItems,
                          Languages.of(context)!.overviewTileRecycledText,
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2)),
                        _richText(
                          amountOfRescuedItems,
                          Languages.of(context)!.overviewTileSavedText,
                        ),
                      ],
                    ),
                  ),
                  if (user.currentUser != null)
                    SizedBox(
                      height: 20,
                      child: TextButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(FontAwesomeIcons.angleRight, size: 12),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                Languages.of(context)!.overviewTileShareText,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        onPressed: () => _createForumPost(
                          user.currentUser!.objectId!,
                          amountOfRescuedItems.toString(),
                        ),
                      ),
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
