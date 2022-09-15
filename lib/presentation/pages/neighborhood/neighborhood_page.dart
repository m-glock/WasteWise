import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/neighborhood/widgets/neighborhood_feed_widget.dart';

import '../../util/custom_icon_button.dart';
import '../../util/data_holder.dart';
import '../../util/graphl_ql_queries.dart';

class NeighborhoodPage extends StatefulWidget {
  const NeighborhoodPage({Key? key}) : super(key: key);

  @override
  State<NeighborhoodPage> createState() => _NeighborhoodPageState();
}

class _NeighborhoodPageState extends State<NeighborhoodPage> {
  bool _isAuthenticated = false;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkIfAuthenticated();
  }

  void _checkIfAuthenticated() async {
    ParseUser? currentUser = await ParseUser.currentUser();
    setState(() {
      _isAuthenticated = currentUser != null;
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

    controller.text = "";
    FocusManager.instance.primaryFocus?.unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(snackBarText))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isAuthenticated
          ? Column(
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
                const NeighborhoodFeedWidget(),
              ],
            )
          : Center(
              child:
                  Text(Languages.of(context)!.neighborhoodNotAuthenticatedText),
            ),
    );
  }
}
