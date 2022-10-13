import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model_classes/zip_code.dart';
import '../../services/data_service.dart';
import '../../util/constants.dart';

class GeneralQueries{

  static String initialQuery = """
    query GetContent(\$languageCode: String!, \$municipalityId: ID!){
      categoryTLS(where:{
        category_id:{have:{municipality_id:{have:{objectId:{equalTo: \$municipalityId}}}}}
        AND:{language_code:{equalTo: \$languageCode}}}){
        edges{
          node{
            title
            article
            category_id{
              objectId
              image_file{
                url
              }
            }
          }
        }
      }

      itemTLS(where:{language_code:{equalTo: \$languageCode}}, last: 500){
        edges{
          node{
            title
            synonyms
            item_id{
              objectId
            }
          }
        }
      }
      
      categoryMythTLS(where:{language_code:{equalTo: \$languageCode}
        AND:{category_myth_id:{have:{category_id:{have:{municipality_id:{have:{objectId:{equalTo: \$municipalityId}}}}}}}}}){
        edges{
          node{
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
    	        source_link
    	        source_name
            }
          }
        }
      }
      
      categoryContentTLS(where:{language_code:{equalTo: \$languageCode}
        AND:{category_content_id:{have:{category_id:{have:{municipality_id:{have:{objectId:{equalTo: \$municipalityId}}}}}}}}}){
        edges{
          node{
            item_list
            category_content_id{
              does_belong
              category_id{
                objectId
              }
            }
          }
        }
      }
      
      categoryCycleTLS(where:{language_code:{equalTo: \$languageCode}
        AND:{category_cycle_id:{have:{category_id:{have:{municipality_id:{have:{objectId:{equalTo: \$municipalityId}}}}}}}}}){
        edges{
          node{
            title
            explanation
            additional_info
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
      }
      
      subcategoryTLS(where:{language_code:{equalTo: \$languageCode}
        AND:{subcategory_id:{have:{category_id:{have:{municipality_id:{have:{objectId:{equalTo: \$municipalityId}}}}}}}}}){
        edges{
          node{
            title
            subcategory_id{
              objectId
              category_id{
                objectId
              }
            }
          }
        }
      }
      
      forumEntryTypeTLS(where:{language_code:{equalTo: \$languageCode}}){
        edges{
          node{
            text
            button_text
            title
            forum_entry_type_id{
              objectId
              type_name
            }
          }
        }
      }

      collectionPoints(where:{municipality_id:{have:{objectId:{equalTo: \$municipalityId}}}}){
        edges{
          node{
            objectId
            opening_hours
            hazardous_materials
            second_hand
            contact_id{
              phone
              fax
              email
              website
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
        }
      }
      
      getDistinctSubcategoriesForCP(languageCode: \$languageCode, municipalityId: \$municipalityId){
        objectId
		    title
      }
      
      collectionPointTypeTLS(where:{language_code:{equalTo: \$languageCode}}){
        edges{
          node{
            title
            collection_point_type_id{
              objectId
              link
            }
          }
        }
      }

      collectionPointSubcategories(where:{subcategory_id:{have:{category_id:{have:{municipality_id:{have:{objectId:{equalTo: \$municipalityId}}}}}}}}){
        edges{
          node{
            collection_point_id{
              objectId
            }
            subcategory_id{
              objectId
            }
          }
        }
      }

      zipCodes(where:{municipality_id:{have:{objectId:{equalTo: \$municipalityId}}}}){
        edges{
          node{
            objectId
            municipality_id{
              objectId
            }
            zip_code
            lat_lng{
              latitude
              longitude
            }
          }
        }
      }
    }
  """;

  static String zipCodeQuery = """
    query GetZipCodes(\$municipalityId: ID!){
      zipCodes(where:{municipality_id:{have:{objectId:{equalTo: \$municipalityId}}}}
        last: 200){
        edges{
          node{
            objectId
            municipality_id{
              objectId
            }
            zip_code
            lat_lng{
              latitude
              longitude
            }
          }
        }
      }
    }
  """;

  static String municipalityQuery = """
    query GetMunicipalities{
      municipalities{
        edges{
          node{
            objectId
            name
          }
        }
      }
    }
  """;

  static String categoryQuery = """
    query GetCategories(\$languageCode: String!, \$municipalityId: ID!){
      categoryTLS(where:{
        category_id:{have:{municipality_id:{have:{objectId:{equalTo: \$municipalityId}}}}}
        AND:{language_code:{equalTo: \$languageCode}}}){
        edges{
          node{
            title
            category_id{
              objectId
              image_file{
                url
              }
            }
          }
        }
      }
    }
  """;

  static Future<List<ZipCode>> getZipCodes(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? municipalityId =
    _prefs.getString(Constants.prefSelectedMunicipalityCode);
    Map<String, dynamic> inputVariables = {
      "municipalityId": municipalityId,
    };

    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(
        document: gql(zipCodeQuery),
        variables: inputVariables,
      ),
    );

    DataService dataService = Provider.of<DataService>(context, listen: false);
    List<dynamic> zipCodes = result.data?["zipCodes"]["edges"];
    for (dynamic zipCodeData in zipCodes) {
      ZipCode zipCode = ZipCode.fromGraphQLData(zipCodeData["node"]);
      dataService.zipCodesById[zipCode.objectId] = zipCode;
    }

    return dataService.zipCodesById.values.toList();
  }

  static Future<void> getMunicipality(
      BuildContext context, DataService dataService) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(document: gql(municipalityQuery)),
    );

    List<dynamic> municipalities = result.data?["municipalities"]["edges"];
    for (dynamic municipality in municipalities) {
      dataService.municipalitiesById[municipality["node"]["objectId"]] =
      municipality["node"]["name"];
    }
  }

}
