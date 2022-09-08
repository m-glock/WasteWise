import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

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
        },
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) return Text(result.exception.toString());
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // get municipalities for selection
        List<dynamic> categoryData = result.data?["getCategories"];
        List<WasteBinCategory> categories = [];
        for (dynamic element in categoryData) {
          categories.add(WasteBinCategory.fromJson(element));
        }

        // display when all data is available
        return categories.isEmpty
            ? Center(
                child:
                    Text(Languages.of(context)!.municipalitySelectedNotFound))
            : Column(
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
                              CachedNetworkImage(
                                imageUrl: category.pictogramUrl,
                                width: 50,
                                height: 50,
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 10)),
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
      },
    );
  }
}
