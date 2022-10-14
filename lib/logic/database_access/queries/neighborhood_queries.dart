class NeighborhoodQueries{

  static String forumEntriesQuery = """
    query GetForumEntries(\$municipalityId: ID!, \$zipCodes: [String!]!){
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
    query GetForumEntryReplies(\$parentEntryId: ID!){
      forumEntries(where:{parent_entry_id:{have:{objectId:{equalTo: \$parentEntryId}}}}){
        edges{
          node{
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
      }
    }
  """;

}