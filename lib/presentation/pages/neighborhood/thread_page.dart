import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/neighborhood/widgets/forum_entry_widget.dart';
import 'package:recycling_app/presentation/util/database_classes/forum_entry.dart';

import '../../util/constants.dart';
import '../../util/custom_icon_button.dart';
import '../../util/data_holder.dart';
import '../../util/graphl_ql_queries.dart';

class ThreadPage extends StatefulWidget {
  const ThreadPage({Key? key, required this.parentForumEntry}) : super(key: key);

  final ForumEntry parentForumEntry;

  @override
  State<ThreadPage> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  final TextEditingController controller = TextEditingController();

  void _createForumReply() async {
    String forumTypeId = DataHolder.forumEntryTypesById.entries
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
        document: gql(GraphQLQueries.createForumPost),
        variables: inputVariables,
      ),
    );

    String snackBarText =
    result.hasException || !result.data?["createForumEntries"]
        ? Languages.of(context)!.cpPostUnsuccessfulText
        : Languages.of(context)!.cpPostSuccessfulText;

    setState(() {
      controller.text = "";
    });

    FocusManager.instance.primaryFocus?.unfocus();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(snackBarText)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.threadPageTitle),
      ),
      body: Query(
        options: QueryOptions(
            document: gql(GraphQLQueries.getForumReplies),
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

          List<dynamic> replyData = result.data?["getForumEntryReplies"];

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
                            showButton: false,
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: replyData.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map<String, dynamic> example = replyData[index];
                              ForumEntry forumEntry = ForumEntry.fromGraphQLData(example);
                              return Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: Constants.tileBorderRadius,
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: double.infinity,
                                child: ForumEntryWidget(forumEntry: forumEntry, showButton: false,),
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
        },
      ),
    );
  }
}
