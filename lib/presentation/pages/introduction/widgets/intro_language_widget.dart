import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

import '../../../i18n/locale_constant.dart';
import '../../../util/constants.dart';

class LanguageIntroScreen extends StatefulWidget {
  const LanguageIntroScreen({Key? key}) : super(key: key);

  @override
  State<LanguageIntroScreen> createState() => _LanguageIntroScreenState();
}

class _LanguageIntroScreenState extends State<LanguageIntroScreen> {
  String languageDefault = Constants.languages.values.first;

  @override
  void initState() {
    super.initState();
    _setLanguage(languageDefault);
  }

  void _setLanguage(String newValue) async {
    setState(() {
      Locale locale = Constants.languages.entries.where((entry) => entry.value == newValue).first.key;
      changeAppLanguage(context, locale.languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //image,
        Text(Languages.of(context)!.languageScreenExplanation, style: Theme.of(context).textTheme.bodyText1,),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        DropdownButton<String>(
          isExpanded: true,
          value: languageDefault,
          onChanged: (String? newValue) {
            languageDefault = newValue!;
            _setLanguage(newValue);
          },
          items: Constants.languages.values
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
  }
}