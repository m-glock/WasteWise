import 'package:json_annotation/json_annotation.dart';

part 'generated/forum_entry_type.g.dart';

@JsonSerializable()
class ForumEntryType{

  final String objectId;
  final String text;
  final String buttonText;
  final String typeName;

  ForumEntryType(this.objectId, this.text, this.buttonText, this.typeName);

  static ForumEntryType fromGraphQlData(Map<String, dynamic> data){
    return ForumEntryType(
        data["forum_entry_type_id"]["objectId"],
        data["text"],
        data["button_text"],
        data["forum_entry_type_id"]["type_name"]
    );
  }

  factory ForumEntryType.fromJson(Map<String, dynamic> json) => _$ForumEntryTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ForumEntryTypeToJson(this);
}