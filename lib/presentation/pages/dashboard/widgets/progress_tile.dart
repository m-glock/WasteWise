import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/logic/database_access/queries/dashboard_queries.dart';

import '../../../../logic/util/user.dart';
import '../../../i18n/languages.dart';
import 'bar_chart_widget.dart';

class ProgressTile extends StatefulWidget {
  const ProgressTile({Key? key}) : super(key: key);

  @override
  State<ProgressTile> createState() => _ProgressTileState();
}

class _ProgressTileState extends State<ProgressTile> {
  DateTime threeMonthsAgo = DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (BuildContext context, User user, child) {
      return Query(
        options: QueryOptions(
          document: gql(DashboardQueries.progressQuery),
          variables: {
            "userId": user.currentUser?.objectId ?? "",
            "date": threeMonthsAgo.toString(),
          },
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) return Text(result.exception.toString());
          if (result.isLoading) {
            return const Center();
          }

          List<dynamic> searchHistoryData = result.data?["searchHistories"]["edges"];

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
                          key: ValueKey(searchHistoryData),
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
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2)),
                              Text(
                                Languages.of(context)!
                                    .progressTileRecycledLabel,
                                style: Theme.of(context).textTheme.bodyText1,
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
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2)),
                              Text(
                                Languages.of(context)!.progressTileSavedLabel,
                                style: Theme.of(context).textTheme.bodyText1,
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
    });
  }
}
