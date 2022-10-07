import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/introduction/widgets/wastebin_explanation_widget.dart';
import 'package:recycling_app/logic/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../logic/data_holder.dart';

class UserDataIntroScreen extends StatefulWidget {
  const UserDataIntroScreen({Key? key}) : super(key: key);

  @override
  State<UserDataIntroScreen> createState() => _UserDataIntroScreenState();
}

class _UserDataIntroScreenState extends State<UserDataIntroScreen> {
  String municipalityDefault = DataHolder.municipalitiesById.values.first;
  String municipalityIdDefault = DataHolder.municipalitiesById.keys.first;

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
              _setMunicipalityId(DataHolder.municipalitiesById[newValue]!);
            },
            items: DataHolder.municipalitiesById.values
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
