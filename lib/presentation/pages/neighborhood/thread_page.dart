import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/logic/database_access/mutations/neighborhood_mutations.dart';
import 'package:recycling_app/logic/database_access/queries/neighborhood_queries.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/neighborhood/widgets/forum_entry_widget.dart';

import '../../../logic/services/data_service.dart';
import '../../../model_classes/forum_entry.dart';
import '../../../logic/util/constants.dart';
import '../../general_widgets/custom_icon_button.dart';

class ThreadPage extends StatefulWidget {
  const ThreadPage({Key? key, required this.parentForumEntry})
      : super(key: key);

  final ForumEntry parentForumEntry;

  @override
  State<ThreadPage> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  final TextEditingController controller = TextEditingController();
  List<ForumEntryWidget> replies = [];

  void _createForumReply() async {
    DataService dataService = Provider.of<DataService>(context, listen: false);
    String forumTypeId = dataService.forumEntryTypesById.entries
        .firstWhere((element) => element.value.typeName == "Question")
        .key;
    Map<String, dynamic> inputVariables = {
      "userId": (await ParseUser.currentUser())?.objectId,
      "text": controller.text,
      "forumEntryTypeId": forumTypeId,
      "parentEntryId": widget.parentForumEntry.objectId
    };

    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(
        document: gql(NeighborhoodMutations.createForumPostMutation),
        variables: inputVariables,
      ),
    );

    Map<String, dynamic>? forumReplyData = result.data?["createForumEntry"];

    String snackBarText = result.hasException || forumReplyData == null
        ? Languages.of(context)!.cpPostUnsuccessfulText
        : Languages.of(context)!.cpPostSuccessfulText;

    FocusManager.instance.primaryFocus?.unfocus();

    if (forumReplyData != null) {
      ForumEntry forumEntry =
          ForumEntry.fromGraphQLData(forumReplyData["forumEntry"], dataService);
      setState(() {
        replies.add(ForumEntryWidget(
          key: ValueKey(forumEntry.objectId),
          forumEntry: forumEntry,
          isRootEntry: false,
        ));
      });
    }

    setState(() {
      controller.text = "";
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(snackBarText)));
  }

  Widget _getWidget() {
    return Padding(
      padding: EdgeInsets.all(Constants.pagePadding),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    ForumEntryWidget(
                      forumEntry: widget.parentForumEntry,
                      isRootEntry: false,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: replies.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: Constants.tileBorderRadius,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          width: double.infinity,
                          child: replies[index],
                        );
                      },
                    ),
                  ],
                )),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    autocorrect: false,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).colorScheme.surface,
                      hintText: Languages.of(context)!.threadReplyHintText,
                      filled: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                CustomIconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  icon: const Icon(Icons.send),
                  onPressed: () => _createForumReply(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.threadPageTitle),
      ),
      body: replies.isNotEmpty
          ? _getWidget()
          : Query(
              options: QueryOptions(
                  document: gql(NeighborhoodQueries.forumRepliesQuery),
                  variables: {
                    "parentEntryId": widget.parentForumEntry.objectId,
                  }),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }
                if (result.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<dynamic> replyData = result.data?["forumEntries"]["edges"];
                DataService dataService =
                    Provider.of<DataService>(context, listen: false);
                for (dynamic element in replyData) {
                  ForumEntry entry =
                      ForumEntry.fromGraphQLData(element["node"], dataService);
                  replies.add(ForumEntryWidget(
                    key: ValueKey(entry.objectId),
                    forumEntry: entry,
                    isRootEntry: false,
                  ));
                }

                return _getWidget();
              },
            ),
    );
  }
}
