import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/settings/widgets/settings_dropdown_button.dart';
import 'package:recycling_app/presentation/pages/settings/widgets/learn_more_alert_dialog.dart';
import 'package:recycling_app/logic/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../logic/util/constants.dart';
import '../../general_widgets/custom_icon_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _learnMore = false;

  @override
  void initState() {
    super.initState();
    _setLearnMore();
  }

  void _setLearnMore() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool? prefLearnMore = _prefs.getBool(Constants.prefLearnMore);
    setState(() {
      _learnMore = prefLearnMore ?? false;
    });
  }

  void _updateLearnMore(bool value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool(Constants.prefLearnMore, value);
    NotificationService notificationService = Provider.of<NotificationService>(context, listen: false);
    if(value) {
      notificationService.startSchedule();
    } else {
      notificationService.stopSchedule();
    }

    setState(() {
      _learnMore = value;
    });
  }

  void loading(bool showOverlay) {
    if(showOverlay){
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
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
                    child: Text(
                      Languages.of(context)!.settingsPageLanguageSetting,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  Expanded(
                    child: SettingsDropdownButton(
                      isLanguageButton: true,
                      loading: loading,
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 2.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      Languages.of(context)!.settingsPageMunicipalitySetting,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  Expanded(
                    child: SettingsDropdownButton(
                      isLanguageButton: false,
                      loading: loading,
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 2.0),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          Languages.of(context)!.settingsPageLearnMoreSetting,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4)),
                        CustomIconButton(
                          onPressed: () =>
                              LearnMoreAlertDialog.showModal(context),
                          icon: const Icon(
                            Icons.info_outline,
                            size: 20,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _learnMore,
                    activeColor: Colors.red,
                    onChanged: (bool value) => _updateLearnMore(value),
                  ),
                ],
              ),
              const Divider(thickness: 2.0),
            ],
          ),
        ),
      ),
    );
  }
}
