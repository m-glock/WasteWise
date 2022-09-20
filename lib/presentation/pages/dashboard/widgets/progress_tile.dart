import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../i18n/languages.dart';
import '../../../util/graphl_ql_queries.dart';
import 'bar_chart_widget.dart';

class ProgressTile extends StatefulWidget {
  const ProgressTile({Key? key}) : super(key: key);

  @override
  State<ProgressTile> createState() => _ProgressTileState();
}

class _ProgressTileState extends State<ProgressTile> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    ParseUser? current = await ParseUser.currentUser();
    setState(() {
      userId = current?.objectId ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return userId == null
        ? const Center(child: CircularProgressIndicator())
        : Query(
            options: QueryOptions(
              document: gql(GraphQLQueries.getProgress),
              variables: {"userId": userId},
            ),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) return Text(result.exception.toString());
              if (result.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              List<dynamic> searchHistoryData = result.data?["getProgress"];

              // display when all data is available
              return Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Center(
                        child: Text(
                          Languages.of(context)!.progressTileTitle,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: BarChartWidget(
                              searchHistoryData: searchHistoryData,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2)),
                                  Text(
                                    Languages.of(context)!
                                        .progressTileRecycledLabel,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5)),
                              Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2)),
                                  Text(
                                    Languages.of(context)!
                                        .progressTileSavedLabel,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
