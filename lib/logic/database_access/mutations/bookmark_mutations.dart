import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class BookmarkMutations{

  static String addBookmarkItemMutation = """
    mutation CreateObject(\$userId: String!, \$itemId: String!){
      createBookmarkedItem(userId: \$userId, itemId: \$itemId)
    }
  """;

  static String deleteBookmarkItemMutation = """
    mutation CreateObject(\$userId: String!, \$itemId: String!){
      deleteBookmarkedItem(userId: \$userId, itemId: \$itemId)
    }
  """;

  static String addBookmarkTipMutation = """
    mutation CreateObject(\$userId: String!, \$tipId: String!){
      createBookmarkedTip(userId: \$userId, tipId: \$tipId)
    }
  """;

  static String deleteBookmarkTipMutation = """
    mutation CreateObject(\$userId: String!, \$tipId: String!){
      deleteBookmarkedTip(userId: \$userId, tipId: \$tipId)
    }
  """;

  static Future<bool> addItemBookmark(String itemId, GraphQLClient client) async {
    ParseUser current = await ParseUser.currentUser();
    Map<String, dynamic> inputVariables = {
      "userId": current.objectId,
      "itemId": itemId,
    };

    QueryResult<Object?> result = await client.query(
      QueryOptions(
        document: gql(addBookmarkItemMutation),
        variables: inputVariables,
      ),
    );
    if(result.hasException) return false;

    return result.data?["createBookmarkedItem"] ?? false;
  }

  static Future<bool> removeItemBookmark(String itemId, GraphQLClient client) async {
    ParseUser current = await ParseUser.currentUser();
    Map<String, dynamic> inputVariables = {
      "userId": current.objectId,
      "itemId": itemId,
    };

    QueryResult<Object?> result = await client.query(
      QueryOptions(
        document: gql(deleteBookmarkItemMutation),
        variables: inputVariables,
      ),
    );
    if(result.hasException) return false;

    return result.data?["deleteBookmarkedItem"] ?? false;
  }

  static Future<bool> addTipBookmark(String tipId, GraphQLClient client) async {
    ParseUser current = await ParseUser.currentUser();
    Map<String, dynamic> inputVariables = {
      "userId": current.objectId,
      "tipId": tipId,
    };

    QueryResult<Object?> result = await client.query(
      QueryOptions(
        document: gql(addBookmarkTipMutation),
        variables: inputVariables,
      ),
    );
    if(result.hasException) return false;

    return result.data?["createBookmarkedTip"] ?? false;
  }

  static Future<bool> removeTipBookmark(String tipId, GraphQLClient client) async {
    ParseUser current = await ParseUser.currentUser();
    Map<String, dynamic> inputVariables = {
      "userId": current.objectId,
      "tipId": tipId,
    };

    QueryResult<Object?> result = await client.query(
      QueryOptions(
        document: gql(deleteBookmarkTipMutation),
        variables: inputVariables,
      ),
    );
    if(result.hasException) return false;

    return result.data?["deleteBookmarkedTip"] ?? false;
  }

}