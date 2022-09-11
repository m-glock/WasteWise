import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/locale_constant.dart';

import '../../../util/constants.dart';

class SettingsDropdownButton extends StatefulWidget{
  const SettingsDropdownButton({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsDropdownButtonState();
}

class _SettingsDropdownButtonState extends State<SettingsDropdownButton>{

  String? valueLanguage;

  @override
  void didChangeDependencies() {
    if(valueLanguage == null) _setLanguage();
    super.didChangeDependencies();
  }

  void _setLanguage() async {
    Locale locale = await getLocale();
    setState(() {
      valueLanguage = Constants.languages[locale];
    });
  }

  void _updateLanguage(String newValue) async {
    Locale locale = Constants.languages.entries.firstWhere((element) => element.value == newValue).key;
    await setLocale(locale.languageCode);
    changeAppLanguage(context, locale.languageCode);
    setState(() {
      valueLanguage = Constants.languages[locale];
    });
  }


  DropdownMenuItem<String> getDropdownMenuItem(String name){
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
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: valueLanguage,
        items: Constants.languages.values
            .map<DropdownMenuItem<String>>((String value) =>
            getDropdownMenuItem(value)
        ).toList(),
        onChanged: (String? newValue) =>
          _updateLanguage(newValue!),
      ),
    );
  }
}