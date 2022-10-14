import 'package:flutter/material.dart';

import '../../../i18n/languages.dart';

class LearnMoreAlertDialog {
  static Future<void> showModal(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(Languages.of(context)!.settingsPageLearnMoreSetting),
            contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            content: SizedBox(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Languages.of(context)!.settingsPageAlertDialogTextStart,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      Languages.of(context)!.settingsPageAlertDialogBulletPoints,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Text(
                    Languages.of(context)!.settingsPageAlertDialogTextEnd,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 24),
            actions: [
              TextButton(
                child: Text(Languages.of(context)!.alertDialogButtonDismiss),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
    );
  }
}
