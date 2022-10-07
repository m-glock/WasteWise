class NeighborhoodQueries{


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

}