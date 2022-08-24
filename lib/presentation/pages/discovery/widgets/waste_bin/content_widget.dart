import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/waste_bin/content_list_widget.dart';

import '../../../../i18n/locale_constant.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({Key? key, required this.categoryId}) : super(key: key);

  final String categoryId;

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  String languageCode = "";
  List<String> itemsYes = [];
  List<String> itemsNo = [];
  String query = """
    query GetCategoryContent(\$languageCode: String!, \$categoryId: String!){
      getCategoryContent(languageCode: \$languageCode, categoryId: \$categoryId){
        title
        language_code
        category_content_id{
          objectId
			    does_belong
    	    category_id{
            objectId
            pictogram
          }
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

        List<dynamic> categoryContent = result.data?["getCategoryContent"];

        if (categoryContent.isEmpty) {
          return const Text("No tips found.");
        }

        if(itemsYes.isEmpty && itemsNo.isEmpty) {
          for (dynamic element in categoryContent) {
            if (element["category_content_id"]["does_belong"]) {
              itemsYes.add(element["title"]);
            } else {
              itemsNo.add(element["title"]);
            }
          }
        }

        // display when all data is available
        return Column(
          children: [
            ContentListWidget(
                backgroundColor: const Color.fromARGB(255, 216, 227, 204),
                showMore: () => {},
                title: Languages.of(context)!.wasteBinYesContentLabel,
                itemNames: itemsYes),
            ContentListWidget(
                backgroundColor: const Color.fromARGB(255, 235, 206, 206),
                showMore: () => {},
                title: Languages.of(context)!.wasteBinNoContentLabel,
                itemNames: itemsNo),
          ],
        );
      },
    );
  }
}