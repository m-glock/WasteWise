import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class SearchMutations{

  static String searchHistoryMutation = """
    mutation CreateObject(\$itemId: String!, \$userId: String!, \$selectedCategoryId: String!, \$sortedCorrectly: Boolean!){
      addToSearchHistory(itemId: \$itemId, userId: \$userId, selectedCategoryId: \$selectedCategoryId, sortedCorrectly: \$sortedCorrectly)
    }
  """;

  static Future<void> addToSearchHistory(
      BuildContext context,
      String itemId,
      String? selectedCategoryId,
      bool? sortedCorrectly
  ) async {
    ParseUser? currentUser = await ParseUser.currentUser();
    if(currentUser != null){
      GraphQLClient client = GraphQLProvider.of(context).value;
      await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.networkOnly,
          document: gql(searchHistoryMutation),
          variables: {
            "itemId": itemId,
            "userId": currentUser.objectId,
            "selectedCategoryId": selectedCategoryId,
            "sortedCorrectly": sortedCorrectly,
          },
        ),
      );
    }
  }
}