class NeighborhoodMutations{

  static String createForumPost = """
    mutation CreateForumEntries(\$userId: String!, \$forumEntryTypeId: String!, \$linkId: String, \$text: String, \$parentEntryId: String){
      createForumEntries(
        userId: \$userId, 
        forumEntryTypeId: \$forumEntryTypeId, 
        linkId: \$linkId,
        text: \$text,
        parentEntryId: \$parentEntryId
      ){
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