import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../../../model_classes/item.dart';
import '../../../presentation/i18n/locale_constant.dart';
import '../../services/data_service.dart';

class ItemQueries{

  static String itemDetailQuery = """
    query GetItem(\$languageCode: String!, \$itemObjectId: String!, \$userId: String!){
      getItem(languageCode: \$languageCode, itemObjectId: \$itemObjectId){
        title
        explanation
        synonyms
        item_id{
          objectId
          subcategory_id{
            objectId
            category_id{
              objectId 
      	    }
          }
        }
      }
      
      getSubcategoryOfItem(languageCode: \$languageCode, itemObjectId: \$itemObjectId){
        title
        explanation
      }
      
      getTipsOfItem(languageCode: \$languageCode, itemId: \$itemObjectId){
        title
        explanation
        short
        tip_id{
          objectId
          image{
            url
          }
          tip_type_id{
            objectId
          }
        }
      }
      
      getTipTypes(languageCode: \$languageCode){
        tip_type_id{
          objectId
          default_label
        }
      }
      
      getBookmarkStatusOfItem(itemObjectId: \$itemObjectId, userId: \$userId){
        objectId
      }
    }
  """;

  static String barcodeMaterialQuery = """
  query GetBarcodeMaterials(\$languageCode: String!, \$municipalityId: String!){
    getBarcodeMaterials(languageCode: \$languageCode, municipalityId: \$municipalityId){
      title
      barcode_material_id{
        binary_value
        category_id{
          objectId
        }
      }
    }
  }
  """;

  static String itemNameQuery = """
    query GetItemName(\$languageCode: String!, \$itemId: String){
      getItemName(languageCode: \$languageCode, itemId: \$itemId){
        title
      }
    }
  """;

  static Future<String> getItemName(
      BuildContext context, String languageCode, String itemObjectId) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object> result = await client.query(
      QueryOptions(
        document: gql(itemNameQuery),
        variables: {
          "languageCode": languageCode,
          "itemId": itemObjectId,
        },
      ),
    );

    return result.data?["getItemName"]["title"];
  }

  static Future<Item> getItemDetails(
      BuildContext context, String itemId, String userId) async {

    Map<String, dynamic> inputVariables = {
      "languageCode": (await getLocale()).languageCode,
      "itemObjectId": itemId,
      "userId": userId,
    };
    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(itemDetailQuery),
        variables: inputVariables,
      ),
    );

    DataService dataService = Provider.of<DataService>(context, listen: false);
    return Item.fromGraphQlData(result.data, dataService)!;
  }
}