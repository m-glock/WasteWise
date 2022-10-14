import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/presentation/i18n/locale_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../logic/database_access/queries/general_queries.dart';
import '../../../../logic/services/data_service.dart';
import '../../../../logic/util/constants.dart';

class SettingsDropdownButton extends StatefulWidget{
  const SettingsDropdownButton({
    Key? key,
    required this.isLanguageButton,
    required this.loading
  }) : super(key: key);

  final bool isLanguageButton;
  final Function(bool show) loading;

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
      valueMunicipality = Provider.of<DataService>(context, listen: false)
          .municipalitiesById[currentMunicipalityId]!;
    });
  }

  void _updateLanguage(String newValue) async {
    // get new language data from backend
    widget.loading(true);

    Locale locale = Constants.languages.entries.firstWhere((element) => element.value == newValue).key;
    await _getNewData(locale: locale);
    await setLocale(locale.languageCode);
    changeAppLanguage(context, locale.languageCode);

    widget.loading(false);
    setState(() {
      valueLanguage = newValue;
    });
  }

  void _updateMunicipality(String newValue) async {
    widget.loading(true);

    DataService dataService = Provider.of<DataService>(context, listen: false);
    String newMunicipalityId = dataService.municipalitiesById.entries.firstWhere((element) => element.value == newValue).key;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(Constants.prefSelectedMunicipalityCode, newMunicipalityId);
    await _getNewData(municipalityId: newMunicipalityId);

    widget.loading(false);
    setState(() {
      valueMunicipality = newValue;
    });
  }

  Future<void> _getNewData({Locale? locale, String? municipalityId}) async {
    locale ??= await getLocale();
    if(municipalityId == null){
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      municipalityId = _prefs.getString(Constants.prefSelectedMunicipalityCode);
    }
    GraphQLClient client = GraphQLProvider.of(context).value;
    QueryResult result = await client.query(
      QueryOptions(
          document: gql(GeneralQueries.initialQuery),
          variables: {
            "languageCode": locale.languageCode,
            "municipalityId": municipalityId ??  "",
          }),
    );
    DataService dataService = Provider.of<DataService>(context, listen: false);
    await dataService.initialDataExtraction(result.data);
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
        : Provider.of<DataService>(context, listen: false)
              .municipalitiesById.values.toList();

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