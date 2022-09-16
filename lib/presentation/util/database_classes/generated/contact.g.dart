// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      json['phone'] as String,
      json['fax'] as String,
      json['email'] as String,
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'phone': instance.phone,
      'fax': instance.fax,
      'email': instance.email,
    };
