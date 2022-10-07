class NeighborhoodQueries{

  static String forumEntriesQuery = """
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

  static String forumRepliesQuery = """
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