class SearchQueries{

  static String searchHistoryQuery = """
    query GetSearchHistory(\$userId: ID){
      searchHistories(where:{user_id:{have:{objectId:{equalTo: \$userId}}}}){
        edges{
    	    node{
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
      }
    }
  """;

  static String recentlyWronglySortedItemQuery = """
    query GetRecentlyWronglySortedItem(\$userId: ID!){
      getRecentlyWronglySortedItem(userId: \$userId)
    }
  """;

  static String recentlyAndOftenSearchedItemsQuery = """
    query RecentlySearched(\$languageCode: String!, \$userId: ID){
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

  static String searchedAndWronglySortedItemsQuery = """
    query GetSearchedAndWronglySortedItems(\$userId: ID!){
      amountOfSearchedItems(userId: \$userId)
      
      amountOfWronglySortedItems(userId: \$userId)
    }
  """;


}