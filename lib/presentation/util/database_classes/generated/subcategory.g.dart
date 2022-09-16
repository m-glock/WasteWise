// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../subcategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subcategory _$SubcategoryFromJson(Map<String, dynamic> json) => Subcategory(
      json['title'] as String,
      json['objectId'] as String,
      json['parentId'] as String,
    );

Map<String, dynamic> _$SubcategoryToJson(Subcategory instance) =>
    <String, dynamic>{
      'title': instance.title,
      'objectId': instance.objectId,
      'parentId': instance.parentId,
    };
