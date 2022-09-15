import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/util/database_classes/forum_entry_type.dart';
import 'package:recycling_app/presentation/util/database_classes/subcategory.dart';

import 'data_holder.dart';
import 'database_classes/cycle.dart';
import 'database_classes/myth.dart';
import 'database_classes/waste_bin_category.dart';

class GraphQLQueries{

  static String initialQuery = """
    query GetContent(\$languageCode: String!, \$municipalityId: String!, \$userId: String!){
      getCategories(languageCode: \$languageCode, municipalityId: \$municipalityId){
        title
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
        }
      }
      
      getAllCategoryContent(languageCode: \$languageCode, municipalityId: \$municipalityId){
        title
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
      
      getMunicipalities{
        objectId
        name
      }
      

      getForumEntryTypes(languageCode: \$languageCode){
        text
        button_text
        forum_entry_type_id{
          objectId
          type_name
        }
      }
      
      amountOfSearchedItems(userId: \$userId)
      
      amountOfWronglySortedItems(userId: \$userId)
    }
  """;

  static String collectionPointQuery = """
    query GetCollectionPoints(\$languageCode: String!, \$municipalityId: String!){
      getCollectionPoints(municipalityId: \$municipalityId){
        objectId
        opening_hours
        link
        contact_id{
          phone
          fax
          email
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
    }
  """;

  static String itemDetailQuery = """
    query GetItem(\$languageCode: String!, \$itemObjectId: String!, \$userId: String!){
      getItem(languageCode: \$languageCode, itemObjectId: \$itemObjectId){
        title
        explanation
        material
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
    query GetCategories(\$languageCode: String!, \$userId: String){
      getTipTypes(languageCode: \$languageCode){
        title
        tip_type_id{
          color
          objectId
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
    query GetForumEntries(\$municipalityId: String!){
      getForumEntries(municipalityId: \$municipalityId){
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
      )
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

  static void initialDataExtraction(dynamic data){
    // get municipalities
    List<dynamic> municipalities = data?["getMunicipalities"];
    for(dynamic municipality in municipalities){
      DataHolder.municipalitiesById[municipality["objectId"]] = municipality["name"];
    }

    // get waste bin categories
    List<dynamic> categories = data?["getCategories"];
    Map<String, WasteBinCategory> wasteBinCategories = {};
    for (dynamic element in categories) {
      WasteBinCategory category = WasteBinCategory.fromJson(element);
      wasteBinCategories[category.objectId] = category;
    }

    // get myths for waste bin categories
    List<dynamic> categoryMyths = data?["getAllCategoryMyths"];
    for (dynamic element in categoryMyths) {
      String categoryId =
      element["category_myth_id"]["category_id"]["objectId"];
      wasteBinCategories[categoryId]?.myths.add(Myth.fromJson(element));
    }

    // get content for waste bin categories
    List<dynamic> categoryContent =
    data?["getAllCategoryContent"];
    for (dynamic element in categoryContent) {
      String categoryId =
      element["category_content_id"]["category_id"]["objectId"];
      if (element["category_content_id"]["does_belong"]) {
        wasteBinCategories[categoryId]?.itemsBelong
            .add(element["title"]);
      } else {
        wasteBinCategories[categoryId]?.itemsDontBelong
            .add(element["title"]);
      }
    }

    // get cycles for waste bin categories
    List<dynamic> categoryCycles = data?["getAllCategoryCycles"];
    for (dynamic element in categoryCycles) {
      String categoryId =
      element["category_cycle_id"]["category_id"]["objectId"];
      wasteBinCategories[categoryId]!.cycleSteps
          .add(Cycle.fromJson(element));
    }

    // save waste bin categories
    DataHolder.categories.addAll(wasteBinCategories);

    // get subcategories
    List<dynamic> subcategories = data?["getSubcategories"];
    for(dynamic element in subcategories){
      String subcategoryId = element["subcategory_id"]["objectId"];
      DataHolder.subcategoriesById[subcategoryId] = Subcategory.fromJson(element);
    }

    //get item names
    List<dynamic> items = data?["getItemNames"];
    for (dynamic element in items) {
      DataHolder.itemNames[element["title"]] = element["item_id"]["objectId"];
      List<String> synonyms = element["synonyms"] != null
          ? element["synonyms"].toString().split(",")
          : [];
      for(String synonym in synonyms){
        DataHolder.itemNames[synonym.trim()] = element["item_id"]["objectId"];
      };
    }

    //get forum types
    List<dynamic> forumEntryTypes = data?["getForumEntryTypes"];
    for(dynamic entryType in forumEntryTypes){
      ForumEntryType type = ForumEntryType.fromJson(entryType);
      DataHolder.forumEntryTypesById[type.objectId] = type;
    }

    // set searched and rescued data amounts
    DataHolder.amountOfSearchedItems = data?["amountOfSearchedItems"];

    DataHolder.amountOfRescuedItems =  data?["amountOfWronglySortedItems"];
  }
}