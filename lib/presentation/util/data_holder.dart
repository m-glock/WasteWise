import 'dart:convert';
import 'dart:io';

import 'package:flutter_map/flutter_map.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recycling_app/presentation/util/database_classes/forum_entry_type.dart';
import 'package:recycling_app/presentation/util/database_classes/subcategory.dart';
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';
import 'package:recycling_app/presentation/util/database_classes/zip_code.dart';

import '../pages/discovery/widgets/collection_point/custom_marker.dart';
import 'database_classes/collection_point.dart';
import 'database_classes/collection_point_type.dart';

class DataHolder{

  static final Map<String, String> municipalitiesById = {};
  static final Map<String, WasteBinCategory> categoriesById = {};
  static final Map<String, Subcategory> subcategoriesById = {};
  static final Map<String, String> itemNames = {};
  static final Map<String, ForumEntryType> forumEntryTypesById = {};
  static final Map<CollectionPoint, Marker> markers = {};
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
    jsonMap["CollectionPoints"] = DataHolder.markers.keys.toList();
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
      DataHolder.markers[cp] = Marker(
        anchorPos: AnchorPos.align(AnchorAlign.top),
        width: 220,
        height: 200,
        point: cp.address.location,
        builder: (ctx) =>
            CustomMarkerWidget(collectionPoint: cp),
      );
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