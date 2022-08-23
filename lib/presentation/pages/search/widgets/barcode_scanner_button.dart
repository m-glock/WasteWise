import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

import '../barcode_scan_page.dart';

class BarcodeScannerButton extends StatefulWidget {
  const BarcodeScannerButton({Key? key}): super(key: key);

  @override
  State<BarcodeScannerButton> createState() => _BarcodeScannerButtonState();
}

class _BarcodeScannerButtonState extends State<BarcodeScannerButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: ElevatedButton(
        child: Row(
          children: [
            const Icon(FontAwesomeIcons.barcode, size: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(Languages.of(context)!.barcodeButtonText),
            )
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BarcodeScanPage()),
          );
        },
      ),
    );
  }
}
