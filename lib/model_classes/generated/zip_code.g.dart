// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../zip_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZipCode _$ZipCodeFromJson(Map<String, dynamic> json) => ZipCode(
      json['objectId'] as String,
      json['municipalityId'] as String,
      json['zipCode'] as String,
      LatLng.fromJson(json['latLng'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ZipCodeToJson(ZipCode instance) => <String, dynamic>{
      'objectId': instance.objectId,
      'municipalityId': instance.municipalityId,
      'zipCode': instance.zipCode,
      'latLng': instance.latLng,
    };
