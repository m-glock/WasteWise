import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/tip_detail_page.dart';

import '../../../../model_classes/tip.dart';
import '../../../icons/custom_icons.dart';

class TipDialogWidget {
  static Future<void> showModal(
      BuildContext context, Tip tip, String subcategory) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder:
            (BuildContext context, void Function(void Function()) setState) {
          return AlertDialog(
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    Languages.of(context)!.aboutText + subcategory,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                const Icon(FontAwesomeIcons.bookmark),
              ],
            ),
            contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            content: Wrap(
              children: [
                Row(
                  children: [
                    const Icon(
                      CustomIcons.lightbulb,
                      size: 30,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    Expanded(
                        child: Text(
                          tip.title,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Expanded(
                    child: Text(
                      tip.short,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actionsPadding: const EdgeInsets.symmetric(horizontal: 24),
            actions: [
              OutlinedButton(
                  child: Text(Languages.of(context)!.alertDialogButtonMoreInfo),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TipDetailPage(tip: tip)),
                    );
                  }),
              OutlinedButton(
                child: Text(Languages.of(context)!.alertDialogButtonDismiss),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          );
        });
      },
    );
  }
}
