import 'data_holder.dart';
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
    }
  """;

  static void extractAndFormatData(dynamic data){
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
  }
}