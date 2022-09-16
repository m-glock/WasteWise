class ForumEntryType{

  final String objectId;
  final String text;
  final String buttonText;
  final String typeName;

  ForumEntryType(this.objectId, this.text, this.buttonText, this.typeName);

  static ForumEntryType fromJson(Map<String, dynamic> data){
    return ForumEntryType(
        data["forum_entry_type_id"]["objectId"],
        data["text"],
        data["button_text"],
        data["forum_entry_type_id"]["type_name"]
    );
  }
}