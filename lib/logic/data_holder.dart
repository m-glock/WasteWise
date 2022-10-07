import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recycling_app/model_classes/subcategory.dart';

import '../model_classes/collection_point.dart';
import '../model_classes/collection_point_type.dart';
import '../model_classes/forum_entry_type.dart';
import '../model_classes/waste_bin_category.dart';
import '../model_classes/zip_code.dart';

class DataHolder{

  static final Map<String, String> municipalitiesById = {};
  static final Map<String, WasteBinCategory> categoriesById = {};
  static final Map<String, Subcategory> subcategoriesById = {};
  static final Map<String, String> itemNames = {};
  static final Map<String, ForumEntryType> forumEntryTypesById = {};
  static final Map<Marker, CollectionPoint> markers = {};
  static final Set<String> cpSubcategories = {};
  static final List<CollectionPointType> collectionPointTypes = [];
  static final Map<String, ZipCode> zipCodesById = {};

  static Future<void> saveDataToFile() async {
    Map<String, dynamic> jsonMap = {};
    jsonMap["Municipalities"] = DataHolder.municipalitiesById;
    jsonMap["Categories"] = DataHolder.categoriesById;
    jsonMap["Subcategories"] = DataHolder.subcategoriesById;
    jsonMap["ItemNames"] = DataHolder.itemNames;
    jsonMap["ForumTypes"] = DataHolder.forumEntryTypesById;
    jsonMap["CollectionPointTypes"] = DataHolder.collectionPointTypes;
    jsonMap["CpSubcategories"] = DataHolder.cpSubcategories.toList();
    jsonMap["CollectionPoints"] = DataHolder.markers.values.toList();
    jsonMap["ZipCodes"] = DataHolder.zipCodesById;

    Directory directory = await getApplicationDocumentsDirectory();
    File dataFile = File('${directory.path}/subcategories.json');
    if(dataFile.existsSync()){
      await dataFile.writeAsString("");
    } else {
      await dataFile.create();
    }
    String json = jsonEncode(jsonMap);
    await dataFile.writeAsString(json);
  }

  static Future<void> readDataFromFile(File file) async {
    final json = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(json);
    DataHolder.municipalitiesById.addAll(Map.from(jsonMap["Municipalities"]));

    for(dynamic entry in Map.from(jsonMap["Subcategories"]).entries){
      DataHolder.subcategoriesById[entry.key] = Subcategory.fromJson(entry.value);
    }
    for(dynamic entry in Map.from(jsonMap["Categories"]).entries){
      DataHolder.categoriesById[entry.key] = WasteBinCategory.fromJson(entry.value);
    }
    for(dynamic entry in Map.from(jsonMap["ForumTypes"]).entries){
      DataHolder.forumEntryTypesById[entry.key] = ForumEntryType.fromJson(entry.value);
    }
    for (dynamic collectionPoint in jsonMap["CollectionPoints"]){
      CollectionPoint cp = CollectionPoint.fromJson(collectionPoint);
      Marker marker = Marker(
        key: ValueKey(cp.objectId),
        anchorPos: AnchorPos.align(AnchorAlign.top),
        width: 35,
        height: 35,
        point: cp.address.location,
        builder: (ctx) => const Icon(Icons.location_on, size: 35,),
      );
      DataHolder.markers[marker] = cp;
    }
    for(dynamic element in jsonMap["CpSubcategories"]){
      DataHolder.cpSubcategories.add(element);
    }
    for(dynamic element in jsonMap["CollectionPointTypes"]){
      DataHolder.collectionPointTypes.add(CollectionPointType.fromJson(element));
    }

    for(dynamic entry in Map.from(jsonMap["ZipCodes"]).entries){
      ZipCode zipCode = ZipCode.fromJson(entry.value);
      DataHolder.zipCodesById[zipCode.objectId] = zipCode;
    }

    DataHolder.itemNames.addAll(Map.from(jsonMap["ItemNames"]));
  }
}