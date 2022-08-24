import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../i18n/locale_constant.dart';
import '../../../../util/database_classes/cycle.dart';

class CycleWidget extends StatefulWidget {
  const CycleWidget({Key? key, required this.categoryId}) : super(key: key);

  final String categoryId;

  @override
  State<CycleWidget> createState() => _CycleWidgetState();
}

class _CycleWidgetState extends State<CycleWidget> {
  String languageCode = "";
  String query = """
    query GetCategoryCycle{
      getCategoryCycle(languageCode: "en", categoryId: "d1SHnrqu1F"){
        title
        explanation
        category_cycle_id{
          position
          image{
            url
          }
		      category_id{
            pictogram
          }
        }
      }
    }
  """;
  int _current = 0;

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

        List<dynamic> cycles = result.data?["getCategoryCycle"];

        if (cycles.isEmpty) {
          return const Text("No tips found.");
        }

        List<Cycle> cycleElements = [];
        for (dynamic element in cycles) {
          cycleElements.add(Cycle(
              element["title"],
              element["explanation"],
              element["category_cycle_id"]["position"],
              element["category_cycle_id"]["image"]["url"]));
        }

        // display when all data is available
        return Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: Row(
            children: [
              Expanded(
                child: CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    padEnds: false,
                    height: MediaQuery.of(context).size.height,
                    scrollDirection: Axis.vertical,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  items: cycleElements.map((element) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(element.imageUrl),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 20)),
                              Text(element.title,
                                  style: Theme.of(context).textTheme.headline3),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 20)),
                              Text(element.explanation,
                                  style: Theme.of(context).textTheme.bodyText1),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
              RotatedBox(
                quarterTurns: 1,
                child: CarouselIndicator(
                  color: Theme.of(context).colorScheme.onSecondary,
                  activeColor: Theme.of(context).colorScheme.secondary,
                  height: 15,
                  count: cycleElements.length,
                  index: _current,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
