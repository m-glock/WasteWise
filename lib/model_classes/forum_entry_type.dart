import 'package:json_annotation/json_annotation.dart';

part 'generated/forum_entry_type.g.dart';

@JsonSerializable()
class ForumEntryType{

  final String objectId;
  final String text;
  final String buttonText;
  final String typeName;
  final String title;

  ForumEntryType(
      this.objectId, this.text, this.buttonText, this.typeName, this.title);

  static ForumEntryType fromGraphQlData(Map<String, dynamic> data){
    return ForumEntryType(
        data["forum_entry_type_id"]["objectId"],
        data["text"],
        data["button_text"],
        data["forum_entry_type_id"]["type_name"],
        data["title"]
    );
  }

  factory ForumEntryType.fromJson(Map<String, dynamic> json) => _$ForumEntryTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ForumEntryTypeToJson(this);
}