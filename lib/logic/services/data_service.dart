import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:recycling_app/logic/database_access/queries/general_queries.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model_classes/collection_point.dart';
import '../../model_classes/collection_point_type.dart';
import '../../model_classes/cycle.dart';
import '../../model_classes/forum_entry_type.dart';
import '../../model_classes/myth.dart';
import '../../model_classes/subcategory.dart';
import '../../model_classes/waste_bin_category.dart';
import '../../model_classes/zip_code.dart';
import '../../presentation/i18n/locale_constant.dart';
import '../util/constants.dart';

class DataService{

  final Map<String, String> municipalitiesById = {};
  final Map<String, WasteBinCategory> categoriesById = {};
  final Map<String, Subcategory> subcategoriesById = {};
  final Map<String, String> itemNames = {};
  final Map<String, ForumEntryType> forumEntryTypesById = {};
  final Map<Marker, CollectionPoint> markers = {};
  final Set<String> cpSubcategories = {};
  final List<CollectionPointType> collectionPointTypes = [];
  final Map<String, ZipCode> zipCodesById = {};

  Future<void> init(BuildContext context) async {
    Directory dir = await getApplicationDocumentsDirectory();
    File dataFile = File('${dir.path}/subcategories.json');

    if(dataFile.existsSync()) {
      await readDataFromFile(dataFile);
    } else {
      await _getDataFromServer(context);
    }
  }

  Future<void> _getDataFromServer(BuildContext context) async {
    Locale locale = await getLocale();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? id = _prefs.getString(Constants.prefSelectedMunicipalityCode);

    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult result = await client.query(
      QueryOptions(
          document: gql(GeneralQueries.initialQuery),
          variables: {
            "languageCode": locale.languageCode,
            "municipalityId": id ??  "",
          }),
    );
    await initialDataExtraction(result.data);
  }

  Future<void> initialDataExtraction(dynamic data) async {
    // get waste bin categories
    List<dynamic> categories = data?["categoryTLS"]["edges"];
    Map<String, WasteBinCategory> wasteBinCategories = {};
    for (dynamic element in categories) {
      if(element["node"]["category_id"]["objectId"] == "ZWHAaWY0YN") continue;
      Uri uri = Uri.parse(element["node"]["category_id"]["image_file"]["url"]);
      http.Response response = await http.get(uri);
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      String imagePath = "${documentDirectory.path}/${element["node"]["title"]}.png";
      File file = File(imagePath);
      if (!file.existsSync()) {
        file.writeAsBytes(response.bodyBytes);
      }

      WasteBinCategory category = WasteBinCategory.fromGraphQlData(element["node"], imagePath);
      wasteBinCategories[category.objectId] = category;
    }

    // get myths for waste bin categories
    List<dynamic> categoryMyths = data?["categoryMythTLS"]["edges"];
    for (dynamic element in categoryMyths) {
      String categoryId =
      element["node"]["category_myth_id"]["category_id"]["objectId"];
      wasteBinCategories[categoryId]?.myths.add(Myth.fromGraphQlData(element["node"]));
    }

    // get content for waste bin categories
    List<dynamic> categoryContent =
    data?["categoryContentTLS"]["edges"];
    for (dynamic element in categoryContent) {
      String categoryId =
      element["node"]["category_content_id"]["category_id"]["objectId"];
      if (element["node"]["category_content_id"]["does_belong"]) {
        for(String item in element["node"]["item_list"]["items"]){
          wasteBinCategories[categoryId]?.itemsBelong
              .add(item);
        }
      } else {
        for(String item in element["node"]["item_list"]["items"]){
          wasteBinCategories[categoryId]?.itemsDontBelong
              .add(item);
        }
      }
    }

    // get cycles for waste bin categories
    List<dynamic> categoryCycles = data?["categoryCycleTLS"]["edges"];
    for (dynamic element in categoryCycles) {
      String? uriString = element["node"]["category_cycle_id"]["image"]?["url"];
      String? imagePath;
      if(uriString != null){
        Uri uri = Uri.parse(uriString);
        http.Response response = await http.get(uri);
        Directory documentDirectory = await getApplicationDocumentsDirectory();
        String fileName = "${element["node"]["category_cycle_id"]["objectId"]}_${element["node"]["title"]}";
        imagePath = "${documentDirectory.path}/$fileName.png";
        File file = File(imagePath);
        if (!file.existsSync()) {
          file.writeAsBytes(response.bodyBytes);
        }
      }

      String categoryId =
      element["node"]["category_cycle_id"]["category_id"]["objectId"];
      wasteBinCategories[categoryId]!.cycleSteps
          .add(Cycle.fromGraphQLData(element["node"], imagePath));
    }

    // save waste bin categories
    categoriesById.clear();
    categoriesById.addAll(wasteBinCategories);

    // get subcategories
    List<dynamic> subcategories = data?["subcategoryTLS"]["edges"];
    for(dynamic element in subcategories){
      String subcategoryId = element["node"]["subcategory_id"]["objectId"];
      subcategoriesById[subcategoryId] = Subcategory.fromGraphQlData(element["node"]);
    }

    //get item names
    List<dynamic> items = data?["itemTLS"]["edges"];
    for (dynamic element in items) {
      itemNames[element["node"]["title"]] = element["node"]["item_id"]["objectId"];
      List<String> synonyms = element["node"]["synonyms"] != null
          ? element["node"]["synonyms"].toString().split(",")
          : [];
      for(String synonym in synonyms){
        itemNames[synonym.trim()] = element["node"]["item_id"]["objectId"];
      };
    }

    //get forum types
    List<dynamic> forumEntryTypes = data?["forumEntryTypeTLS"]["edges"];
    for(dynamic entryType in forumEntryTypes){
      ForumEntryType type = ForumEntryType.fromGraphQlData(entryType["node"]);
      forumEntryTypesById[type.objectId] = type;
    }

    // get collection point types
    List<dynamic> collectionPointTypeData = data?["collectionPointTypeTLS"]["edges"];
    collectionPointTypes.clear();
    for (dynamic cpType in collectionPointTypeData) {
      collectionPointTypes
          .add(CollectionPointType.fromGraphQLData(cpType["node"]));
    }

    // get collection points
    List<dynamic> collectionPoints = data?["collectionPoints"]["edges"];

    // build markers for collection points
    Map<String, CollectionPoint> cpByObjectId = {};
    if(markers.isNotEmpty) markers.clear();
    for (dynamic cp in collectionPoints) {
      CollectionPoint collectionPoint = CollectionPoint.fromGraphQlData(cp["node"], this);
      cpByObjectId[collectionPoint.objectId] = collectionPoint;
      Marker marker = Marker(
        key: ValueKey(collectionPoint.objectId),
        anchorPos: AnchorPos.align(AnchorAlign.top),
        width: 35,
        height: 35,
        point: collectionPoint.address.location,
        builder: (ctx) => const Icon(Icons.location_on, size: 35,),
      );
      markers[marker] = collectionPoint;
    }

    // get accepted subcategories for all collection points
    List<dynamic> subcategoriesOfCP =
    data?["collectionPointSubcategories"]["edges"];
    for (dynamic subcategoryCpPair in subcategoriesOfCP) {
      String collectionPointObjectId =
      subcategoryCpPair["node"]["collection_point_id"]["objectId"];
      String subcategoryObjectId =
      subcategoryCpPair["node"]["subcategory_id"]["objectId"];
      Subcategory? subcategory =
      subcategoriesById[subcategoryObjectId];
      if (subcategory != null) {
        cpByObjectId[collectionPointObjectId]
            ?.acceptedSubcategories
            .add(subcategory);
      }
    }

    // get available subcategories for filter dropdown
    List<dynamic> availableSubcategories = data?["getDistinctSubcategoriesForCP"];
    cpSubcategories.clear();
    for (dynamic element in availableSubcategories) {
      cpSubcategories.add(element["title"]);
    }

    // get zip codes for municipalities
    if(zipCodesById.isEmpty){
      List<dynamic> zipCodes = data?["zipCodes"]["edges"];
      for (dynamic zipCodeData in zipCodes) {
        ZipCode zipCode = ZipCode.fromGraphQLData(zipCodeData["node"]);
        zipCodesById[zipCode.objectId] = zipCode;
      }
    }

    try{
      saveDataToFile();
    } catch(e){
      debugPrint("Error saving data to file");
    }
  }

  Future<void> saveDataToFile() async {
    Map<String, dynamic> jsonMap = {};
    jsonMap["Municipalities"] = municipalitiesById;
    jsonMap["Categories"] = categoriesById;
    jsonMap["Subcategories"] = subcategoriesById;
    jsonMap["ItemNames"] = itemNames;
    jsonMap["ForumTypes"] = forumEntryTypesById;
    jsonMap["CollectionPointTypes"] = collectionPointTypes;
    jsonMap["CpSubcategories"] = cpSubcategories.toList();
    jsonMap["CollectionPoints"] = markers.values.toList();
    jsonMap["ZipCodes"] = zipCodesById;

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

  Future<void> readDataFromFile(File file) async {
    final json = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(json);
    municipalitiesById.addAll(Map.from(jsonMap["Municipalities"]));

    for(dynamic entry in Map.from(jsonMap["Subcategories"]).entries){
      subcategoriesById[entry.key] = Subcategory.fromJson(entry.value);
    }
    for(dynamic entry in Map.from(jsonMap["Categories"]).entries){
      categoriesById[entry.key] = WasteBinCategory.fromJson(entry.value);
    }
    for(dynamic entry in Map.from(jsonMap["ForumTypes"]).entries){
      forumEntryTypesById[entry.key] = ForumEntryType.fromJson(entry.value);
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
      markers[marker] = cp;
    }
    for(dynamic element in jsonMap["CpSubcategories"]){
      cpSubcategories.add(element);
    }
    for(dynamic element in jsonMap["CollectionPointTypes"]){
      collectionPointTypes.add(CollectionPointType.fromJson(element));
    }

    for(dynamic entry in Map.from(jsonMap["ZipCodes"]).entries){
      ZipCode zipCode = ZipCode.fromJson(entry.value);
      zipCodesById[zipCode.objectId] = zipCode;
    }

    itemNames.addAll(Map.from(jsonMap["ItemNames"]));
  }
}