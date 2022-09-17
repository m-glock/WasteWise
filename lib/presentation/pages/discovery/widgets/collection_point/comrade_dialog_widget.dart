import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

import '../../../../util/data_holder.dart';
import '../../../../util/graphl_ql_queries.dart';

class ComradeDialogWidget {
  static Future<void> showModal(
      BuildContext context, String? subcategoryTitle) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        String subcategoryDefault = subcategoryTitle ?? DataHolder.cpSubcategories.first;
        return StatefulBuilder(builder:
            (BuildContext context, void Function(void Function()) setState) {
          return AlertDialog(
            title: Text(
              Languages.of(context)!.cpAlliesButtonShareTitle,
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            contentPadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            content: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      Languages.of(context)!.cpAlliesButtonShareExplanation,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: subcategoryDefault,
                      onChanged: (String? newValue) {
                        setState(() {
                          subcategoryDefault = newValue!;
                        });
                      },
                      items: DataHolder.cpSubcategories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actionsPadding: const EdgeInsets.symmetric(horizontal: 24),
            actions: [
              TextButton(
                child: Text(Languages.of(context)!.cpAlliesButtonCancelText),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(Languages.of(context)!.cpAlliesButtonShareText),
                onPressed: () =>
                    _searchForComrades(context, subcategoryDefault),
              ),
            ],
          );
        });
      },
    );
  }

  static void _searchForComrades(
      BuildContext context, String subcategoryTitle) async {
    ParseUser? currentUser = await ParseUser.currentUser();
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Languages.of(context)!.notLoggedInErrorText),
      ));
    }

    String subcategoryId = DataHolder.subcategoriesById.entries
        .firstWhere((element) => element.value.title == subcategoryTitle)
        .key;
    String forumTypeId = DataHolder.forumEntryTypesById.entries
        .firstWhere((element) => element.value.typeName == "Ally")
        .key;
    Map<String, dynamic> inputVariables = {
      "userId": currentUser?.objectId,
      "forumEntryTypeId": forumTypeId,
      "linkId": subcategoryId
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
            ? Languages.of(context)!.cpAllyUnsuccessfulText
            : Languages.of(context)!.cpAllySuccessfulText;

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(snackBarText))
    );
    Navigator.pop(context);
  }
}
