// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../cycle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cycle _$CycleFromJson(Map<String, dynamic> json) => Cycle(
      json['title'] as String,
      json['explanation'] as String,
      json['position'] as int,
      json['imagePath'] as String,
    );

Map<String, dynamic> _$CycleToJson(Cycle instance) => <String, dynamic>{
      'title': instance.title,
      'explanation': instance.explanation,
      'position': instance.position,
      'imagePath': instance.imagePath,
    };
