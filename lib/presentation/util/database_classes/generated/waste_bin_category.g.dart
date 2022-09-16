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
      (json['myths'] as List<dynamic>)
          .map((e) => Myth.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['cycleSteps'] as List<dynamic>)
          .map((e) => Cycle.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['itemsBelong'] as List<dynamic>).map((e) => e as String).toList(),
      (json['itemsDontBelong'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$WasteBinCategoryToJson(WasteBinCategory instance) =>
    <String, dynamic>{
      'title': instance.title,
      'objectId': instance.objectId,
      'pictogramUrl': instance.pictogramUrl,
      'myths': instance.myths.map((e) => e.toJson()).toList(),
      'itemsBelong': instance.itemsBelong,
      'itemsDontBelong': instance.itemsDontBelong,
      'cycleSteps': instance.cycleSteps.map((e) => e.toJson()).toList(),
    };
