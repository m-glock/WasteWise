class SearchQueries{

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

  static String getRecentlyWronglySortedItem = """
    query GetRecentlyWronglySortedItem(\$userId: String!){
      getRecentlyWronglySortedItem(userId: \$userId)
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

  static String recentlyAndOftenSearchedItemQuery = """
    query GetSearchedAndWronglySortedItems(\$userId: String!){
      amountOfSearchedItems(userId: \$userId)
      
      amountOfWronglySortedItems(userId: \$userId)
    }
  """;


}