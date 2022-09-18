import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:http/http.dart' as http;

import '../../../i18n/locale_constant.dart';
import '../../../util/database_classes/waste_bin_category.dart';
import '../../../util/graphl_ql_queries.dart';

class WasteBinExplanationScreen extends StatefulWidget {
  const WasteBinExplanationScreen(
      {Key? key, required this.municipalityId, required this.municipalityName})
      : super(key: key);

  final String municipalityId;
  final String municipalityName;

  @override
  State<WasteBinExplanationScreen> createState() =>
      _WasteBinExplanationScreenState();
}

class _WasteBinExplanationScreenState extends State<WasteBinExplanationScreen> {
  String languageCode = "";
  List<WasteBinCategory> categories = [];

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

  void _getCategories(dynamic categoryData) async {
    List<WasteBinCategory> categoryList = [];
    for (dynamic element in categoryData) {
      Uri uri = Uri.parse(element["category_id"]["image_file"]["url"]);
      http.Response response = await http.get(uri);
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      String imagePath = "${documentDirectory.path}/${element["title"]}.png";
      File file = File(imagePath);
      if (!file.existsSync()) {
        file.writeAsBytes(response.bodyBytes);
      }
      categoryList.add(WasteBinCategory.fromGraphQlData(element, imagePath));
    }

    setState(() {
      categories = categoryList;
    });
  }

  Widget _getWidget() {
    return Column(
      children: [
        Text(
          Languages.of(context)!.municipalitySelectedTitle +
              widget.municipalityName +
              ":",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: const EdgeInsets.all(0),
            childAspectRatio: 3 / 2,
            children: [
              ...categories.map((category) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.file(
                      File(category.imageFilePath),
                      width: 50,
                      height: 50,
                      errorBuilder: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text(
                      category.title,
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return categories.isNotEmpty
        ? _getWidget()
        : Query(
            options: QueryOptions(
              document: gql(GraphQLQueries.categoryQuery),
              variables: {
                "languageCode": languageCode,
                "municipalityId": widget.municipalityId,
              },
            ),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) return Text(result.exception.toString());
              if (result.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              // get categories to display
              List<dynamic> categoryData = result.data?["getCategories"];
              _getCategories(categoryData);

              // display when all data is available
              return _getWidget();
            },
          );
  }
}
