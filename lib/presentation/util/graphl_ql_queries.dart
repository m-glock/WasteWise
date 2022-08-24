import 'package:flutter_map/flutter_map.dart';

import '../pages/discovery/widgets/collection_point/custom_marker.dart';
import 'data_holder.dart';
import 'database_classes/collection_point.dart';
import 'database_classes/collection_point_type.dart';
import 'database_classes/cycle.dart';
import 'database_classes/myth.dart';
import 'database_classes/waste_bin_category.dart';

class GraphQLQueries{

  static String initialQuery = """
    query GetContent(\$languageCode: String!, \$municipalityId: String!){
      getCategories(languageCode: \$languageCode, municipalityId: \$municipalityId){
        title
        category_id{
          objectId
          image_file{
            url
          }
          hex_color
        }
      }
      
      getItemNames(languageCode: \$languageCode){
        title
        synonyms
        item_id{
          objectId
        }
      }
      
      getAllCategoryMyths(languageCode: \$languageCode, municipalityId: \$municipalityId){
        question
        answer
        category_myth_id{
          category_id{
     		    objectId
      	    image_file{
        	    url
      	    }
      	    hex_color
    	    }
    	    is_correct
        }
      }
      
      getAllCategoryContent(languageCode: \$languageCode, municipalityId: \$municipalityId){
        title
        category_content_id{
          does_belong
          category_id{
            objectId
          }
        }
      }
      
      getAllCategoryCycles(languageCode: \$languageCode, municipalityId: \$municipalityId){
        title
        explanation
        category_cycle_id{
          position
          image{
            url
          }
		      category_id{
		        objectId
            pictogram
          }
        }
      }
      
      getCollectionPoints(municipalityId: \$municipalityId){
        objectId
        opening_hours
        link
        contact_id{
          phone
          fax
          email
        }
        address_id{
          street
          number
          zip_code
          district
          location{
            latitude
            longitude
          }
        }
        collection_point_type_id{
          objectId
        }
      }
      
      getCollectionPointSubcategories(languageCode: \$languageCode, municipalityId: \$municipalityId){
        objectId
		    title
      }
      
      getCollectionPointTypes(languageCode: \$languageCode){
        title
        collection_point_type_id{
          objectId
        }
      }
    }
  """;

  static String itemDetailQuery = """
    query GetItem(\$languageCode: String!, \$itemObjectId: String!){
      getItem(languageCode: \$languageCode, itemObjectId: \$itemObjectId){
        title
        explanation
        material
        item_id{
          subcategory_id{
            objectId
            category_id{
              objectId
        	    hex_color
        	    image_file{
                url
              }  
      	    }
          }
        }
      }
      
      getSubcategoryOfItem(languageCode: \$languageCode, itemObjectId: \$itemObjectId){
        title
        explanation
      }
    }
  """;

  static void initialDataExtraction(dynamic data){
    // get waste bin categories
    List<dynamic> categories = data?["getCategories"];
    Map<String, WasteBinCategory> wasteBinCategories = {};
    for (dynamic element in categories) {
      WasteBinCategory category = WasteBinCategory.fromJson(element);
      wasteBinCategories[category.objectId] = category;
    }

    // get myths for waste bin categories
    List<dynamic> categoryMyths = data?["getAllCategoryMyths"];
    for (dynamic element in categoryMyths) {
      String categoryId =
      element["category_myth_id"]["category_id"]["objectId"];
      wasteBinCategories[categoryId]?.myths.add(Myth.fromJson(element));
    }

    // get content for waste bin categories
    List<dynamic> categoryContent =
    data?["getAllCategoryContent"];
    for (dynamic element in categoryContent) {
      String categoryId =
      element["category_content_id"]["category_id"]["objectId"];
      if (element["category_content_id"]["does_belong"]) {
        wasteBinCategories[categoryId]?.itemsBelong
            .add(element["title"]);
      } else {
        wasteBinCategories[categoryId]?.itemsDontBelong
            .add(element["title"]);
      }
    }

    // get cycles for waste bin categories
    List<dynamic> categoryCycles = data?["getAllCategoryCycles"];
    for (dynamic element in categoryCycles) {
      String categoryId =
      element["category_cycle_id"]["category_id"]["objectId"];
      wasteBinCategories[categoryId]!.cycleSteps
          .add(Cycle.fromJson(element));
    }

    // save waste bin categories
    DataHolder.categories.addAll(wasteBinCategories.values);

    //get item names
    List<dynamic> items = data?["getItemNames"];
    for (dynamic element in items) {
      //TODO: entry for each synonym?
      DataHolder.itemNames[element["title"]] =
      element["item_id"]["objectId"];
    }


    // get collection point types
    List<dynamic> collectionPointTypes = data?["getCollectionPointTypes"];
    for(dynamic cpType in collectionPointTypes){
      DataHolder.collectionPointTypes.add(CollectionPointType.fromJson(cpType));
    }

    // get collection points
    List<dynamic> collectionPoints = data?["getCollectionPoints"];

    // build markers for collection points
    for (dynamic cp in collectionPoints) {
      CollectionPoint collectionPoint = CollectionPoint.fromJson(cp);
      Marker marker = Marker(
        anchorPos: AnchorPos.align(AnchorAlign.top),
        width: 220,
        height: 200,
        point: collectionPoint.address.location,
        builder: (ctx) =>
            CustomMarkerWidget(collectionPoint: collectionPoint),
      );
      DataHolder.markers[marker] = collectionPoint;
    }

    // get available subcategories for filter dropdown
    List<dynamic> availableSubcategories = data?["getCollectionPointSubcategories"];
    for (dynamic element in availableSubcategories) {
      DataHolder.cpSubcategories.add(element["title"]);
    }
  }
}