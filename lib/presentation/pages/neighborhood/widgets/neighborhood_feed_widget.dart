import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/util/database_classes/forum_entry_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../i18n/languages.dart';
import '../../../util/constants.dart';
import '../../../util/custom_icon_button.dart';
import '../../../util/data_holder.dart';
import '../../../util/graphl_ql_queries.dart';
import 'forum_entry_widget.dart';

class NeighborhoodFeedWidget extends StatefulWidget {
  const NeighborhoodFeedWidget({Key? key}) : super(key: key);

  @override
  State<NeighborhoodFeedWidget> createState() => _NeighborhoodFeedWidgetState();
}

class _NeighborhoodFeedWidgetState extends State<NeighborhoodFeedWidget> {
  String? municipalityId;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setMunicipality();
  }

  void _setMunicipality() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? currentMunicipalityId =
        _prefs.getString(Constants.prefSelectedMunicipalityCode);
    setState(() {
      municipalityId = currentMunicipalityId;
    });
  }


  void _createForumPost() async {
    String forumTypeId = DataHolder.forumEntryTypesById.entries
        .firstWhere((element) => element.value.typeName == "Question")
        .key;
    Map<String, dynamic> inputVariables = {
      "userId": (await ParseUser.currentUser())?.objectId,
      "forumEntryTypeId": forumTypeId,
      "questionText": controller.text,
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

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(snackBarText))
    );
  }

  @override
  Widget build(BuildContext context) {
    return municipalityId == null
        ? const Center(child: CircularProgressIndicator())
        : Query(
            options: QueryOptions(
                fetchPolicy: FetchPolicy.networkOnly,
                document: gql(GraphQLQueries.getForumEntries),
                variables: {"municipalityId": municipalityId}),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }
              if (result.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              List<dynamic> forumEntries = result.data?["getForumEntries"];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomIconButton(
                    onPressed: () => {},
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    icon: const Icon(FontAwesomeIcons.filter),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          autocorrect: false,
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).colorScheme.surface,
                            labelText: "Content",
                            filled: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                      CustomIconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.send),
                        onPressed: () => _createForumPost(),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: forumEntries.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> entry = forumEntries[index];
                        ForumEntryType type = DataHolder.forumEntryTypesById[
                        entry["forum_entry_type_id"]["objectId"]]!;
                        return ForumEntryWidget(
                          userName: entry["user_id"]["username"],
                          userPictureUrl: entry["user_id"]["avatar_picture"]
                          ?["url"],
                          type: type,
                          createdAt: DateTime.parse(entry["createdAt"]),
                          linkId: entry["link_id"],
                          questionText: entry["question_text"],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
    );
  }
}
