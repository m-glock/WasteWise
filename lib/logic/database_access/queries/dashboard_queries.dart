import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../model_classes/tip.dart';
import '../../../presentation/i18n/locale_constant.dart';

class DashboardQueries{

  static String compareInNeighborhoodQuery = """
    query CompareInNeighborhood(\$userId: ID!, \$municipalityId: ID!, \$zipCodes: [String!]!){
      compareInNeighborhood(
        userId: \$userId, 
        municipalityId: \$municipalityId, 
        zipCodes: \$zipCodes
      )
    }
  """;

  static String randomTipQuery = """
    query GetRandomTip(\$languageCode: String!){
      getRandomTip(languageCode: \$languageCode){
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
    }
  """;

  static String progressQuery = """
    query SearchHistories(\$userId: ID!, \$date: Date!){
      searchHistories(where:{user_id:{have:{objectId:{equalTo: \$userId}}}AND:{createdAt:{greaterThanOrEqualTo:\$date}}}){
        edges{
          node{
            objectId
            sorted_correctly
            createdAt
          }
        }
      }
    }
  """;

  static Future<Tip> getRandomTip(BuildContext context) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult<Object?> result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(randomTipQuery),
        variables: {"languageCode": (await getLocale()).languageCode},
      ),
    );

    return Tip.fromGraphQlData(result.data?["getRandomTip"]);
  }

}