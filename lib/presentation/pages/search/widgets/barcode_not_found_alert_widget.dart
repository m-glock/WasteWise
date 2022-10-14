import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class BarcodeNotFoundAlertWidget {
  static Future<void> showModal(BuildContext context, bool itemFound) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              itemFound
                  ? Languages.of(context)!.alertDialogNoItemTitle
                  : Languages.of(context)!.alertDialogNoPackagingTitle
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          content: Text(
              itemFound
                  ? Languages.of(context)!.alertDialogNoItemExplanation
                  : Languages.of(context)!.alertDialogNoPackagingExplanation
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 24),
          actions: [
            OutlinedButton(
              child: Text(Languages.of(context)!.barcodeAlertDialogButtonText),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
