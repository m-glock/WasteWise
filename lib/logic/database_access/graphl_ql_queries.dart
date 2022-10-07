import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class GraphQLQueries{

  static String initialQuery = """
    query GetContent(\$languageCode: String!, \$municipalityId: String!){
      getCategories(languageCode: \$languageCode, municipalityId: \$municipalityId){
        title
        article
        category_id{
          objectId
          image_file{
            url
          }
        }
      }
      
      getItemNames(languageCode: \$languageCode){
        title
        synonyms
        item_id{
          objectId
        }
      }
      
      getAllCategoryMyths(languageCode: \$languageCode, municipalityId: \$municipalityId){
        question
        answer
        category_myth_id{
          category_id{
     		    objectId
      	    image_file{
        	    url
      	    }
      	    hex_color
    	    }
    	    is_correct
    	    source_link
    	    source_name
        }
      }
      
      getAllCategoryContent(languageCode: \$languageCode, municipalityId: \$municipalityId){
        item_list
        category_content_id{
          does_belong
          category_id{
            objectId
          }
        }
      }
      
      getAllCategoryCycles(languageCode: \$languageCode, municipalityId: \$municipalityId){
        title
        explanation
        additional_info
        category_cycle_id{
          position
          image{
            url
          }
		      category_id{
		        objectId
            pictogram
          }
        }
      }
      
      getSubcategories(languageCode: \$languageCode, municipalityId: \$municipalityId){
        title
        subcategory_id{
          objectId
          category_id{
            objectId
          }
        }
      }

      getForumEntryTypes(languageCode: \$languageCode){
        text
        button_text
        title
        forum_entry_type_id{
          objectId
          type_name
        }
      }
      
      getCollectionPoints(municipalityId: \$municipalityId){
        objectId
        opening_hours
        hazardous_materials
        second_hand
        contact_id{
          phone
          fax
          email
          website
        }
        address_id{
          street
          number
          zip_code
          district
          location{
            latitude
            longitude
          }
        }
        collection_point_type_id{
          objectId
        }
      }
      
      getDistinctSubcategoriesForCP(languageCode: \$languageCode, municipalityId: \$municipalityId){
        objectId
		    title
      }
      
      getCollectionPointTypes(languageCode: \$languageCode){
        title
        collection_point_type_id{
          objectId
          link
        }
      }
      
      getSubcategoriesOfAllCollectionPoints(languageCode: \$languageCode, municipalityId: \$municipalityId){
        collection_point_id{
          objectId
        }
        subcategory_id{
          objectId
        }
      }
      
      getZipCodes(municipalityId: \$municipalityId){
        objectId
        municipality_id{
          objectId
        }
        zip_code
        lat_lng{
          latitude
          longitude
        }
      }
    }
  """;

  static String getZipCodes = """
    query GetZipCodes(\$municipalityId: String!){
      getZipCodes(municipalityId: \$municipalityId){
        objectId
        municipality_id{
          objectId
        }
        zip_code
        lat_lng{
          latitude
          longitude
        }
      }
    }
  """;

  static String recentlyAndOftenSearchedItemQuery = """
    query GetSearchedAndWronglySortedItems(\$userId: String!){
      amountOfSearchedItems(userId: \$userId)
      
      amountOfWronglySortedItems(userId: \$userId)
    }
  """;

  static String itemDetailQuery = """
    query GetItem(\$languageCode: String!, \$itemObjectId: String!, \$userId: String!){
      getItem(languageCode: \$languageCode, itemObjectId: \$itemObjectId){
        title
        explanation
        synonyms
        item_id{
          objectId
          subcategory_id{
            objectId
            category_id{
              objectId 
      	    }
          }
        }
      }
      
      getSubcategoryOfItem(languageCode: \$languageCode, itemObjectId: \$itemObjectId){
        title
        explanation
      }
      
      getTipsOfItem(languageCode: \$languageCode, itemId: \$itemObjectId){
        title
        explanation
        short
        tip_id{
          objectId
          image{
            url
          }
          tip_type_id{
            objectId
          }
        }
      }
      
      getTipTypes(languageCode: \$languageCode){
        tip_type_id{
          objectId
          default_label
        }
      }
      
      getBookmarkStatusOfItem(itemObjectId: \$itemObjectId, userId: \$userId){
        objectId
      }
    }
  """;

  static String tipListQuery = """
    query GetTips(\$languageCode: String!, \$userId: String){
      getTipTypes(languageCode: \$languageCode){
        title
        tip_type_id{
          objectId
          color
          default_label
        }
      }
      
      getTips(languageCode: \$languageCode){
        tip_id{
          objectId
    	    tip_type_id{
    	      objectId
      	    color
    	    },
    	    image{
    	      url
    	    }
  	    }, 
        title,
        explanation,
        short
      }
      
      getTipSubcategories{
        tip_id{
          objectId
        }
        subcategory_id{
          objectId
        }
      }
      
      getTipBookmarks(userId: \$userId){
        tip_id{
          objectId
        }
      }
    }
  """;

  static String tipDetailQuery = """
    query GetTip(\$languageCode: String!, \$tipId: String!){
      getTip(languageCode: \$languageCode, tipId: \$tipId){
        tip_id{
          objectId
    	    tip_type_id{
    	      objectId
      	    color
    	    },
    	    image{
    	      url
    	    }
  	    }, 
        title,
        explanation,
        short
      }
    }
  """;

  static String municipalityQuery = """
    query GetMunicipalities{
      getMunicipalities{
        objectId
        name
      }
    }
  """;

  static String barcodeMaterialQuery = """
  query GetBarcodeMaterials(\$languageCode: String!, \$municipalityId: String!){
    getBarcodeMaterials(languageCode: \$languageCode, municipalityId: \$municipalityId){
      title
      barcode_material_id{
        binary_value
        category_id{
          objectId
        }
      }
    }
  }
  """;

  static String categoryQuery = """
    query GetContent(\$languageCode: String!, \$municipalityId: String!){
      getCategories(languageCode: \$languageCode, municipalityId: \$municipalityId){
        title
        category_id{
          objectId
          image_file{
            url
          }
        }
      }
    }
  """;

  static String searchHistoryQuery = """
    query GetSearchHistory(\$languageCode: String!, \$userId: String){
      getSearchHistory(languageCode: \$languageCode, userId: \$userId){
        createdAt
        item_id{
          objectId
          subcategory_id{
            category_id{
              objectId
            }
          }
        }
        selected_category_id{
          objectId
        }
      }
    }
  """;

  static String bookmarkedItemsQuery = """
    query GetAllItemBookmarksForUser(\$languageCode: String!, \$userId: String){
      getAllItemBookmarksForUser(languageCode: \$languageCode, userId: \$userId){
        title
        item_id{
          objectId
        }
      }
      
      getAllTipBookmarksForUser(languageCode: \$languageCode, userId: \$userId){
        title
        tip_id{
          objectId
        }
      }
    }
  """;

  static String getItemName = """
    query GetItemName(\$languageCode: String!, \$itemId: String){
      getItemName(languageCode: \$languageCode, itemId: \$itemId){
        title
      }
    }
  """;

  static String getRecentlyAndOftenSearched = """
    query RecentlySearched(\$languageCode: String!, \$userId: String){
      recentlySearched(languageCode: \$languageCode, userId: \$userId){
        title
        item_id{
          objectId
        }
      }
      
      oftenSearched(languageCode: \$languageCode){
        title
        item_id{
          objectId
        }
      }
    }
  """;

  static String getForumEntries = """
    query GetForumEntries(\$municipalityId: String!, \$zipCodes: [String!]!){
      getForumEntries(municipalityId: \$municipalityId, zipCodes: \$zipCodes){
        objectId
        createdAt
        forum_entry_type_id{
          objectId
        }
        user_id{
          username
          avatar_picture{
            url
          }
        }
        link_id
        text
      }
    }
  """;

  static String getForumReplies = """
    query GetForumEntryReplies(\$parentEntryId: String!){
      getForumEntryReplies(parentEntryId: \$parentEntryId){
        objectId
        createdAt
        forum_entry_type_id{
          objectId
        }
        user_id{
          username
          avatar_picture{
            url
          }
        }
        link_id
        text
      }
    }
  """;

  static String compareInNeighborhood = """
    query CompareInNeighborhood(\$userId: String!, \$municipalityId: String!, \$zipCodes: [String!]!){
      compareInNeighborhood(
        userId: \$userId, 
        municipalityId: \$municipalityId, 
        zipCodes: \$zipCodes
      )
    }
  """;

  static String getRandomTip = """
    query GetRandomTip(\$languageCode: String!){
      getRandomTip(languageCode: \$languageCode){
        title
        explanation
        short
        tip_id{
          objectId
          image{
            url
          }
          tip_type_id{
            objectId
          }
        }
      }
    }
  """;

  static String getProgress = """
    query GetProgress(\$userId: String!){
      getProgress(userId: \$userId){
        objectId
        sorted_correctly
        createdAt
      }
    }
  """;

  static String getRecentlyWronglySortedItem = """
    query GetRecentlyWronglySortedItem(\$userId: String!){
      getRecentlyWronglySortedItem(userId: \$userId)
    }
  """;

  static String searchHistoryMutation = """
    mutation CreateObject(\$itemId: String!, \$userId: String!, \$selectedCategoryId: String!, \$sortedCorrectly: Boolean!){
      addToSearchHistory(itemId: \$itemId, userId: \$userId, selectedCategoryId: \$selectedCategoryId, sortedCorrectly: \$sortedCorrectly)
    }
  """;

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

  static String createForumPost = """
    mutation CreateForumEntries(\$userId: String!, \$forumEntryTypeId: String!, \$linkId: String, \$text: String, \$parentEntryId: String){
      createForumEntries(
        userId: \$userId, 
        forumEntryTypeId: \$forumEntryTypeId, 
        linkId: \$linkId,
        text: \$text,
        parentEntryId: \$parentEntryId
      ){
        objectId
        createdAt
        forum_entry_type_id{
          objectId
        }
        user_id{
          username
          avatar_picture{
            url
          }
        }
        link_id
        text
      }
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
        document: gql(GraphQLQueries.addBookmarkItemMutation),
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
        document: gql(GraphQLQueries.deleteBookmarkItemMutation),
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
        document: gql(GraphQLQueries.addBookmarkTipMutation),
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
        document: gql(GraphQLQueries.deleteBookmarkTipMutation),
        variables: inputVariables,
      ),
    );
    if(result.hasException) return false;

    return result.data?["deleteBookmarkedTip"] ?? false;
  }

}