class DashboardQueries{

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

}