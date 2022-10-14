class NeighborhoodMutations{

  static String createForumPostMutation = """
    mutation CreateForumEntries(\$userId: ID!, \$forumEntryTypeId: ID!, \$linkId: String, \$text: String, \$parentEntryId: ID){
      createForumEntry(input:{fields:{
        user_id:{link:\$userId}
        link_id: \$linkId
        parent_entry_id:{link:\$parentEntryId}
        forum_entry_type_id:{link:\$forumEntryTypeId}
        text: \$text
      }}){
        forumEntry{
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
  """;

}