// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../waste_bin_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WasteBinCategory _$WasteBinCategoryFromJson(Map<String, dynamic> json) =>
    WasteBinCategory(
      json['title'] as String,
      json['objectId'] as String,
      json['pictogramUrl'] as String,
    );

Map<String, dynamic> _$WasteBinCategoryToJson(WasteBinCategory instance) =>
    <String, dynamic>{
      'title': instance.title,
      'objectId': instance.objectId,
      'pictogramUrl': instance.pictogramUrl,
    };
