class SearchMutations{

  static String searchHistoryMutation = """
    mutation CreateObject(\$itemId: String!, \$userId: String!, \$selectedCategoryId: String!, \$sortedCorrectly: Boolean!){
      addToSearchHistory(itemId: \$itemId, userId: \$userId, selectedCategoryId: \$selectedCategoryId, sortedCorrectly: \$sortedCorrectly)
    }
  """;

}