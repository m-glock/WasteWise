import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class BarcodeNotFoundAlertWidget {
  static Future<void> showModal(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Languages.of(context)!.barcodeAlertDialogTitle),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          content: Text(Languages.of(context)!.barcodeAlertDialogExplanation),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 24),
          actions: [
            TextButton(
              child: Text(Languages.of(context)!.barcodeAlertDialogButtonText),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
