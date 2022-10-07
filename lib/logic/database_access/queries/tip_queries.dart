import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../model_classes/tip.dart';
import '../../../presentation/i18n/locale_constant.dart';

class TipQueries{

  static String tipListQuery = """
    query GetTips(\$languageCode: String!, \$userId: String){
      getTipTypes(languageCode: \$languageCode){
        title
        tip_type_id{
          objectId
          color
          default_label
        }
      }
      
      getTips(languageCode: \$languageCode){
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
      
      getTipSubcategories{
        tip_id{
          objectId
        }
        subcategory_id{
          objectId
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
    query GetTip(\$languageCode: String!, \$tipId: String!){
      getTip(languageCode: \$languageCode, tipId: \$tipId){
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

    return Tip.fromGraphQlData(result.data?["getTip"], bookmarked: true);
  }
}