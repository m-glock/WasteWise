import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/introduction/widgets/wastebin_explanation_widget.dart';
import 'package:recycling_app/logic/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../logic/services/data_service.dart';

class UserDataIntroScreen extends StatefulWidget {
  const UserDataIntroScreen({Key? key}) : super(key: key);

  @override
  State<UserDataIntroScreen> createState() => _UserDataIntroScreenState();
}

class _UserDataIntroScreenState extends State<UserDataIntroScreen> {
  late String municipalityDefault;
  late String municipalityIdDefault;

  @override
  void initState() {
    super.initState();
    DataService dataService = Provider.of<DataService>(context, listen: false);
    municipalityDefault = dataService.municipalitiesById.values.first;
    municipalityIdDefault = dataService.municipalitiesById.keys.first;
  }

  void _setMunicipalityId(String municipalityObjectId) async {
    municipalityIdDefault = municipalityObjectId;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(
        Constants.prefSelectedMunicipalityCode, municipalityObjectId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //Image(image: image),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          Text(
            Languages.of(context)!.municipalityScreenExplanation,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          DropdownButton<String>(
            isExpanded: true,
            value: municipalityDefault,
            onChanged: (String? newValue) {
              setState(() {
                municipalityDefault = newValue!;
              });
              _setMunicipalityId(Provider.of<DataService>(context, listen: false).municipalitiesById[newValue]!);
            },
            items: Provider.of<DataService>(context, listen: false).municipalitiesById.values
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          WasteBinExplanationScreen(
            municipalityId: municipalityIdDefault,
            municipalityName: municipalityDefault,
          ),
        ],
      ),
    );
  }
}
