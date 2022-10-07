class BookmarkQueries{

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
}