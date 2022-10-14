import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../model_classes/tip.dart';
import '../../../presentation/i18n/locale_constant.dart';

class TipQueries{

  static String tipListQuery = """
    query GetTips(\$languageCode: String!, \$userId: ID){
      tipTypeTLS(where:{language_code:{equalTo: \$languageCode}}){
        edges{
          node{
            title
            tip_type_id{
              objectId
              color
              default_label
            }
          }
        }
      }
      
      
      tipTLS(where:{language_code:{equalTo: \$languageCode}}){
        edges{
          node{
            tip_id{
              objectId
    	        tip_type_id{
    	          objectId
      	        color
    	        },
    	        image{
    	          url
    	        }
  	        }, 
            title,
            explanation,
            short
          }
        }
      }
      
      tipSubcategories{
        edges{
          node{
            tip_id{
              objectId
            }
            subcategory_id{
              objectId
            }
          }
        }
      }
      
      getTipBookmarks(userId: \$userId){
        tip_id{
          objectId
        }
      }
    }
  """;

  static String tipDetailQuery = """
    query GetTip(\$languageCode: String!, \$tipId: ID!){
      tipTLS(where:{tip_id:{have:{objectId:{equalTo: \$tipId}}}
        AND:{language_code:{equalTo: \$languageCode}}}){
        edges{
          node{
            tip_id{
              objectId
    	        tip_type_id{
    	          objectId
      	        color
    	        },
    	        image{
    	          url
    	        }
  	        }, 
            title,
            explanation,
            short
          }
        }
      }
    }
  """;

  static Future<Tip> getTipDetails(BuildContext context, String tipId) async {
    Locale locale = await getLocale();
    Map<String, dynamic> inputVariables = {
      "languageCode": locale.languageCode,
      "tipId": tipId,
    };

    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(tipDetailQuery),
        variables: inputVariables,
      ),
    );

    return Tip.fromGraphQlData(result.data?["tipTLS"]["edges"][0], bookmarked: true);
  }
}