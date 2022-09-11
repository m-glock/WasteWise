import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/locale_constant.dart';
import 'package:recycling_app/presentation/util/data_holder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../util/constants.dart';

class SettingsDropdownButton extends StatefulWidget{
  const SettingsDropdownButton({Key? key, required this.isLanguageButton}) : super(key: key);

  final bool isLanguageButton;

  @override
  State<StatefulWidget> createState() => _SettingsDropdownButtonState();
}

class _SettingsDropdownButtonState extends State<SettingsDropdownButton>{

  String? valueLanguage;
  String? valueMunicipality;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(valueLanguage == null) _setLanguage();
    if(valueMunicipality == null) _setMunicipality();
  }

  void _setLanguage() async {
    Locale locale = await getLocale();
    setState(() {
      valueLanguage = Constants.languages[locale];
    });
  }

  void _setMunicipality() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? currentMunicipalityId = _prefs.getString(Constants.prefSelectedMunicipalityCode);
    setState(() {
      valueMunicipality = DataHolder.municipalitiesById[currentMunicipalityId]!;
    });
  }

  void _updateLanguage(String newValue) async {
    Locale locale = Constants.languages.entries.firstWhere((element) => element.value == newValue).key;
    await setLocale(locale.languageCode);
    changeAppLanguage(context, locale.languageCode);
    setState(() {
      valueLanguage = newValue;
    });
  }

  void _updateMunicipality(String newValue) async {
    String newMunicipalityId = DataHolder.municipalitiesById.entries.firstWhere((element) => element.value == newValue).key;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(Constants.prefSelectedMunicipalityCode, newMunicipalityId);
    setState(() {
      valueMunicipality = newValue;
    });
  }

  DropdownMenuItem<String> _getDropdownMenuItem(String name){
    return DropdownMenuItem<String>(
      value: name,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Text(name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropdownValues = widget.isLanguageButton
        ? Constants.languages.values.toList()
        : DataHolder.municipalitiesById.values.toList();

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: widget.isLanguageButton
            ? valueLanguage
            : valueMunicipality,
        items: dropdownValues
            .map<DropdownMenuItem<String>>((String value) =>
            _getDropdownMenuItem(value)
        ).toList(),
        onChanged: (String? newValue) =>
          widget.isLanguageButton
              ? _updateLanguage(newValue!)
              : _updateMunicipality(newValue!),
      ),
    );
  }
}