import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/waste_bin/myth_detail_widget.dart';
import 'package:recycling_app/presentation/util/database_classes/myth.dart';

import '../../../../i18n/locale_constant.dart';

class MythWidget extends StatefulWidget {
  const MythWidget({Key? key, required this.categoryId}) : super(key: key);

  final String categoryId;

  @override
  State<MythWidget> createState() => _MythWidgetState();
}

class _MythWidgetState extends State<MythWidget> {
  String languageCode = "";
  String query = """
    query GetCategoryMyths(\$languageCode: String!, \$categoryId: String!){
      getCategoryMyths(languageCode: \$languageCode, categoryId: \$categoryId){
        question
        answer
        category_myth_id{
          is_correct
        }
      }
    }
  """;

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
      options: QueryOptions(document: gql(query), variables: {
        "languageCode": languageCode,
        "categoryId": widget.categoryId,
      }),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) return Text(result.exception.toString());
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        List<dynamic> categoryMyths = result.data?["getCategoryMyths"];

        if (categoryMyths.isEmpty) {
          return const Text("No myths found.");
        }

        List<Myth> myths = [];
        for (dynamic element in categoryMyths) {
          myths.add(Myth(element["question"], element["answer"],
              element["category_myth_id"]["is_correct"]));
        }

        // display when all data is available
        return Container(
          margin: const EdgeInsets.only(top: 15),
          child: ListView(
            children: [
              ...myths.map((myth) {
                return MythDetailWidget(myth: myth);
              })
            ],
          ),
        );
      },
    );
  }
}
