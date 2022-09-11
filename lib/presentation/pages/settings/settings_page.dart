import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/settings/widgets/SettingsDropdownButton.dart';

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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(Languages.of(context)!.settingsPageLanguageSetting),
                ),
                const Expanded(
                  child: SettingsDropdownButton(isLanguageButton: true),
                ),
              ],
            ),
            const Divider(thickness: 2.0),
            Row(
              children: [
                Expanded(
                  child: Text(Languages.of(context)!.settingsPageMunicipalitySetting),
                ),
                const Expanded(
                  child: SettingsDropdownButton(isLanguageButton: false),
                ),
              ],
            ),
            const Divider(thickness: 2.0),
          ],
        ),
      ),
    );
  }
}
