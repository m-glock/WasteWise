// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../collection_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionPoint _$CollectionPointFromJson(Map<String, dynamic> json) =>
    CollectionPoint(
      json['objectId'] as String,
      json['link'] as String,
      json['openingHours'] as String,
      Contact.fromJson(json['contact'] as Map<String, dynamic>),
      Address.fromJson(json['address'] as Map<String, dynamic>),
      CollectionPointType.fromJson(
          json['collectionPointType'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CollectionPointToJson(CollectionPoint instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'link': instance.link,
      'openingHours': instance.openingHours,
      'contact': instance.contact.toJson(),
      'address': instance.address.toJson(),
      'collectionPointType': instance.collectionPointType.toJson(),
    };
