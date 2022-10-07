import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
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
import '../database_access/graphl_ql_queries.dart';
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
          document: gql(GraphQLQueries.initialQuery),
          variables: {
            "languageCode": locale.languageCode,
            "municipalityId": id ??  "",
          }),
    );
    await initialDataExtraction(result.data);
  }

  Future<void> initialDataExtraction(dynamic data) async {
    // get waste bin categories
    List<dynamic> categories = data?["getCategories"];
    Map<String, WasteBinCategory> wasteBinCategories = {};
    for (dynamic element in categories) {
      Uri uri = Uri.parse(element["category_id"]["image_file"]["url"]);
      http.Response response = await http.get(uri);
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      String imagePath = "${documentDirectory.path}/${element["title"]}.png";
      File file = File(imagePath);
      if (!file.existsSync()) {
        file.writeAsBytes(response.bodyBytes);
      }

      WasteBinCategory category = WasteBinCategory.fromGraphQlData(element, imagePath);
      wasteBinCategories[category.objectId] = category;
    }

    // get myths for waste bin categories
    List<dynamic> categoryMyths = data?["getAllCategoryMyths"];
    for (dynamic element in categoryMyths) {
      String categoryId =
      element["category_myth_id"]["category_id"]["objectId"];
      wasteBinCategories[categoryId]?.myths.add(Myth.fromGraphQlData(element));
    }

    // get content for waste bin categories
    List<dynamic> categoryContent =
    data?["getAllCategoryContent"];
    for (dynamic element in categoryContent) {
      String categoryId =
      element["category_content_id"]["category_id"]["objectId"];
      if (element["category_content_id"]["does_belong"]) {
        for(String item in element["item_list"]["items"]){
          wasteBinCategories[categoryId]?.itemsBelong
              .add(item);
        }
      } else {
        for(String item in element["item_list"]["items"]){
          wasteBinCategories[categoryId]?.itemsDontBelong
              .add(item);
        }
      }
    }

    // get cycles for waste bin categories
    List<dynamic> categoryCycles = data?["getAllCategoryCycles"];
    for (dynamic element in categoryCycles) {
      String? uriString = element["category_cycle_id"]["image"]?["url"];
      String? imagePath;
      if(uriString != null){
        Uri uri = Uri.parse(uriString);
        http.Response response = await http.get(uri);
        Directory documentDirectory = await getApplicationDocumentsDirectory();
        String fileName = "${element["category_cycle_id"]["objectId"]}_${element["title"]}";
        imagePath = "${documentDirectory.path}/$fileName.png";
        File file = File(imagePath);
        if (!file.existsSync()) {
          file.writeAsBytes(response.bodyBytes);
        }
      }

      String categoryId =
      element["category_cycle_id"]["category_id"]["objectId"];
      wasteBinCategories[categoryId]!.cycleSteps
          .add(Cycle.fromGraphQLData(element, imagePath));
    }

    // save waste bin categories
    categoriesById.clear();
    categoriesById.addAll(wasteBinCategories);

    // get subcategories
    List<dynamic> subcategories = data?["getSubcategories"];
    for(dynamic element in subcategories){
      String subcategoryId = element["subcategory_id"]["objectId"];
      subcategoriesById[subcategoryId] = Subcategory.fromGraphQlData(element);
    }

    //get item names
    List<dynamic> items = data?["getItemNames"];
    for (dynamic element in items) {
      itemNames[element["title"]] = element["item_id"]["objectId"];
      List<String> synonyms = element["synonyms"] != null
          ? element["synonyms"].toString().split(",")
          : [];
      for(String synonym in synonyms){
        itemNames[synonym.trim()] = element["item_id"]["objectId"];
      };
    }

    //get forum types
    List<dynamic> forumEntryTypes = data?["getForumEntryTypes"];
    for(dynamic entryType in forumEntryTypes){
      ForumEntryType type = ForumEntryType.fromGraphQlData(entryType);
      forumEntryTypesById[type.objectId] = type;
    }

    // get collection point types
    List<dynamic> collectionPointTypes = data?["getCollectionPointTypes"];
    collectionPointTypes.clear();
    for (dynamic cpType in collectionPointTypes) {
      collectionPointTypes
          .add(CollectionPointType.fromGraphQLData(cpType));
    }

    // get collection points
    List<dynamic> collectionPoints = data?["getCollectionPoints"];

    // build markers for collection points
    Map<String, CollectionPoint> cpByObjectId = {};
    if(markers.isNotEmpty) markers.clear();
    for (dynamic cp in collectionPoints) {
      CollectionPoint collectionPoint = CollectionPoint.fromGraphQlData(cp, this);
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
    data?["getSubcategoriesOfAllCollectionPoints"];
    for (dynamic subcategoryCpPair in subcategoriesOfCP) {
      String collectionPointObjectId =
      subcategoryCpPair["collection_point_id"]["objectId"];
      String subcategoryObjectId =
      subcategoryCpPair["subcategory_id"]["objectId"];
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
      List<dynamic> zipCodes = data?["getZipCodes"];
      for (dynamic zipCodeData in zipCodes) {
        ZipCode zipCode = ZipCode.fromGraphQLData(zipCodeData);
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