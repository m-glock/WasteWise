import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/settings/widgets/SettingsDropdownButton.dart';

import '../../util/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.settingsPageTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.pagePadding),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(Languages.of(context)!.settingsPageLanguageSetting),
              trailing: const SettingsDropdownButton(),
            ),
            const Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 2.0,
            ),
            /*ListTile(
              title: Text(Languages.of(context)!.settingsPageMunicipalitySetting),
              trailing: const SettingsDropdownButton(),
            ),
            const Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 2.0,
            ),*/
          ],
        ),
      ),
    );
  }
}