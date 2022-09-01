import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../i18n/locale_constant.dart';
import '../../../util/graphl_ql_queries.dart';

class WasteBinExplanationScreen extends StatefulWidget {
  const WasteBinExplanationScreen({Key? key, required this.municipalityId}) : super(key: key);

  final String municipalityId;

  @override
  State<WasteBinExplanationScreen> createState() => _WasteBinExplanationScreenState();
}

class _WasteBinExplanationScreenState extends State<WasteBinExplanationScreen> {
  String languageCode = "";

  @override
  void initState() {
    super.initState();
    _getLanguageCode();
  }

  void _getLanguageCode() async {
    Locale locale = await getLocale();
    setState(() {
      languageCode = locale.languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(GraphQLQueries.categoryQuery),
        variables: {
          "languageCode": languageCode,
          "municipalityId": widget.municipalityId,
        }
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) return Text(result.exception.toString());
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // get municipalities for selection
        List<dynamic> categories = result.data?["getCategories"];


        // display when all data is available
        return Center(
          child: Text("id: ${widget.municipalityId}"),
        );
      },
    );
  }
}