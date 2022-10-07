import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/i18n/locale_constant.dart';

import '../../../../model_classes/tip.dart';
import '../../../i18n/languages.dart';
import '../../../icons/custom_icons.dart';
import '../../../../logic/database_access/graphl_ql_queries.dart';
import '../../discovery/tip_detail_page.dart';

class ActionTile extends StatefulWidget {
  const ActionTile({Key? key}) : super(key: key);

  @override
  State<ActionTile> createState() => _ActionTileState();
}

class _ActionTileState extends State<ActionTile> {
  String? languageCode;

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
    return languageCode == null ? const Center(child: CircularProgressIndicator()) : Query(
      options: QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GraphQLQueries.getRandomTip),
        variables: {"languageCode": languageCode},
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) return Text(result.exception.toString());
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // get municipalities for selection
        dynamic tipData = result.data?["getRandomTip"];
        Tip tip = Tip.fromGraphQlData(tipData);

        // display when all data is available
        return Flexible(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CustomIcons.lightbulb),
                  const Padding(padding: EdgeInsets.only(right: 5)),
                  Center(
                    child: Text(
                      Languages.of(context)!.tipTileTitle,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 7)),
              Expanded(
                child: Text(
                  tip.short,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Flexible(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(FontAwesomeIcons.angleRight, size: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          Languages.of(context)!.tipTileButtonText,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TipDetailPage(tip: tip),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
