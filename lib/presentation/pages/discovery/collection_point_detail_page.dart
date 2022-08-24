import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/util/database_classes/collection_point.dart';

import '../../i18n/locale_constant.dart';

class CollectionPointDetailPage extends StatefulWidget {
  const CollectionPointDetailPage({Key? key, required this.collectionPoint})
      : super(key: key);

  final CollectionPoint collectionPoint;

  @override
  State<CollectionPointDetailPage> createState() =>
      _CollectionPointDetailPageState();
}

class _CollectionPointDetailPageState extends State<CollectionPointDetailPage> {
  String bulletPoint = "\u2022 ";
  String languageCode = "";
  String query = """
    query GetSubcategoriesOfCollectionPoint(\$languageCode: String!, \$collectionPointId: String!){
      getSubcategoriesOfCollectionPoint(languageCode: \$languageCode, collectionPointId: \$collectionPointId){
        title
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

  List<Widget> _getFormattedOpeningHours() {
    List<String> openingHours = widget.collectionPoint.openingHours.split("|");
    List<String> weekdays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    List<Widget> openingHoursWithDay = [];

    for (int i = 0; i < weekdays.length; i++) {
      openingHoursWithDay.add(Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(weekdays.elementAt(i)),
            Expanded(
              child: Text(openingHours.elementAt(i), textAlign: TextAlign.end),
            ),
          ],
        ),
      ));
    }
    return openingHoursWithDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.collectionPoint.collectionPointType.title),
      ),
      body: Query(
        options: QueryOptions(document: gql(query), variables: {
          "languageCode": languageCode,
          "collectionPointId": widget.collectionPoint.objectId,
        }),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) return Text(result.exception.toString());
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          List<dynamic> subcategories =
              result.data?["getSubcategoriesOfCollectionPoint"];

          if (subcategories.isEmpty) {
            return const Text("No subcategories found.");
          }

          // build markers for collection points
          final List<String> subcategoryNames = [];
          for (dynamic element in subcategories) {
            subcategoryNames.add(element["title"]);
          }

          // display when all data is available
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 30, 20),
            child: Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(FontAwesomeIcons.locationDot, size: 25),
                    ),
                    Text(widget.collectionPoint.address.toString()),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        children: const [
                          Icon(FontAwesomeIcons.clock, size: 25),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            alignment: Alignment.centerLeft,
                            height: 25,
                            child: Text(
                                Languages.of(context)!.cpDetailsOpeningHours),
                          ),
                          ..._getFormattedOpeningHours(),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        children: const [
                          Icon(Icons.assignment_turned_in_outlined, size: 25),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            alignment: Alignment.centerLeft,
                            height: 25,
                            child: Text(
                                Languages.of(context)!.cpDetailItemsAccepted),
                          ),
                          ...subcategoryNames.map((item) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text("$bulletPoint $item"));
                          }).toList()
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
