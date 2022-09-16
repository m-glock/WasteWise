// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      json['street'] as String,
      json['number'] as String,
      json['zipCode'] as String,
      json['district'] as String,
      LatLng.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'street': instance.street,
      'number': instance.number,
      'zipCode': instance.zipCode,
      'district': instance.district,
      'location': instance.location,
    };
