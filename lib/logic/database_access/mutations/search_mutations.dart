import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class SearchMutations{

  static String searchHistoryMutation = """
    mutation CreateObject(\$itemId: ID!, \$userId: ID!, \$selectedCategoryId: ID!, \$sortedCorrectly: Boolean!){
      createSearchHistory(input:{fields:{
        item_id:{link:\$itemId}
        user_id:{link:\$userId}
        selected_category_id:{link:\$selectedCategoryId}
        sorted_correctly: \$sortedCorrectly
      }}){
        searchHistory{
          objectId
      }}
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