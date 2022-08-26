import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../i18n/locale_constant.dart';
import '../../../util/graphl_ql_queries.dart';

class UserDataIntroScreen extends StatefulWidget {
  const UserDataIntroScreen({Key? key}) : super(key: key);

  @override
  State<UserDataIntroScreen> createState() => _UserDataIntroScreenState();
}

class _UserDataIntroScreenState extends State<UserDataIntroScreen> {
  String languageCode = "";
  String? municipalityDefault;
  String? selectedObjectId;

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
          document: gql(GraphQLQueries.municipalityQuery),
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) return Text(result.exception.toString());
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // get municipalities for selection
        List<dynamic> municipalities = result.data?["getMunicipalities"];
        Map<String, String> municipalitiesById = {};
        for (dynamic municipality in municipalities) {
          municipalitiesById[municipality["name"]] = municipality["objectId"];
        }
        municipalityDefault ??= municipalitiesById.keys.first;

        // display when all data is available
        return Column(
          children: [
            //Image(image: image),
            const Text("Every municipality in Germany has its own rules and "
                "might even differ in the type of waste bins they have available"
                " for sorting waste. Please let us know where "
                "you live so that we can adapt the app accordingly."),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            DropdownButton<String>(
              isExpanded: true,
              value: municipalityDefault,
              onChanged: (String? newValue) {
                setState(() {
                  municipalityDefault = newValue!;
                  selectedObjectId = municipalitiesById[newValue];
                  //TODO save in sharedprefs on "next" or immediately?
                });
              },
              items: municipalitiesById.keys
                  .map<DropdownMenuItem<String>>(
                      (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
          ],
        );
      },
    );
  }
}