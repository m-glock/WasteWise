// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../myth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Myth _$MythFromJson(Map<String, dynamic> json) => Myth(
      json['question'] as String,
      json['answer'] as String,
      json['isCorrect'] as bool,
      json['sourceUrl'] as String,
      json['sourceName'] as String,
    );

Map<String, dynamic> _$MythToJson(Myth instance) => <String, dynamic>{
      'question': instance.question,
      'answer': instance.answer,
      'isCorrect': instance.isCorrect,
      'sourceUrl': instance.sourceUrl,
      'sourceName': instance.sourceName,
    };
