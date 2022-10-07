// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      json['phone'] as String,
      fax: json['fax'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'phone': instance.phone,
      'fax': instance.fax,
      'email': instance.email,
      'website': instance.website,
    };
