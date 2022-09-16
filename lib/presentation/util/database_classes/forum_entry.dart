import '../data_holder.dart';
import 'forum_entry_type.dart';

class ForumEntry {
  final String objectId;
  final String userName;
  final String? userPictureUrl;
  final ForumEntryType type;
  final DateTime createdAt;
  final String? linkId;
  final String? questionText;

  ForumEntry(this.objectId, this.userName, this.userPictureUrl, this.type, this.createdAt,
      {this.linkId, this.questionText});

  static ForumEntry fromGraphQLData(Map<String, dynamic> entry){
    return ForumEntry(
      entry["objectId"],
      entry["user_id"]["username"],
      entry["user_id"]["avatar_picture"]?["url"],
      DataHolder.forumEntryTypesById[entry["forum_entry_type_id"]["objectId"]]!,
      DateTime.parse(entry["createdAt"]),
      linkId: entry["link_id"],
      questionText: entry["text"],
    );
  }
}
