import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/introduction/widgets/wastebin_explanation_widget.dart';
import 'package:recycling_app/presentation/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../util/graphl_ql_queries.dart';

class UserDataIntroScreen extends StatefulWidget {
  const UserDataIntroScreen({Key? key}) : super(key: key);

  @override
  State<UserDataIntroScreen> createState() => _UserDataIntroScreenState();
}

class _UserDataIntroScreenState extends State<UserDataIntroScreen> {
  String? municipalityDefault;
  String? municipalityIdDefault;

  void _setMunicipalityId(String municipalityObjectId) async {
    municipalityIdDefault = municipalityObjectId;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(
        Constants.prefSelectedMunicipalityCode,
        municipalityObjectId
    );
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

        if (municipalityDefault == null) {
          municipalityDefault = municipalitiesById.keys.first;
          _setMunicipalityId(municipalitiesById.values.first);
        }

        // display when all data is available
        return Column(
          children: [
            //Image(image: image),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            Text(
              Languages.of(context)!.municipalityScreenExplanation,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            DropdownButton<String>(
              isExpanded: true,
              value: municipalityDefault,
              onChanged: (String? newValue) {
                setState(() {
                  municipalityDefault = newValue!;
                });
                _setMunicipalityId(municipalitiesById[newValue]!);
              },
              items: municipalitiesById.keys
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            WasteBinExplanationScreen(municipalityId: municipalityIdDefault ?? ""),
          ],
        );
      },
    );
  }
}
