// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../forum_entry_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForumEntryType _$ForumEntryTypeFromJson(Map<String, dynamic> json) =>
    ForumEntryType(
      json['objectId'] as String,
      json['text'] as String,
      json['buttonText'] as String,
      json['typeName'] as String,
      json['title'] as String,
    );

Map<String, dynamic> _$ForumEntryTypeToJson(ForumEntryType instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'text': instance.text,
      'buttonText': instance.buttonText,
      'typeName': instance.typeName,
      'title': instance.title,
    };
