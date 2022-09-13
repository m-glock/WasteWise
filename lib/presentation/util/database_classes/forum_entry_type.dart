class ForumEntryType{

  final String objectId;
  final String text;
  final String buttonText;

  ForumEntryType(this.objectId, this.text, this.buttonText);

  static ForumEntryType fromJson(Map<String, dynamic> data){
    return ForumEntryType(
        data["forum_entry_type_id"]["objectId"],
        data["text"],
        data["button_text"]
    );
  }
}