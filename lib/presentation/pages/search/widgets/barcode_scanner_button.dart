import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:http/http.dart' as http;
import 'package:recycling_app/presentation/pages/search/barcode_item_detail_page.dart';

import 'barcode_not_found_alert_widget.dart';

class BarcodeScannerButton extends StatefulWidget {
  const BarcodeScannerButton({Key? key}): super(key: key);

  @override
  State<BarcodeScannerButton> createState() => _BarcodeScannerButtonState();
}

class _BarcodeScannerButtonState extends State<BarcodeScannerButton> {

  Future<void> _scanBarcodeNormal() async {
    String barcodeScanRes = "";
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on Exception {
      barcodeScanRes = "Failed to get platform version.";
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // also return if barcode scan was cancelled
    if (!mounted || barcodeScanRes == "-1") return;

    Map<String, String> params = {
      "ean": barcodeScanRes,
      "cmd": "query",
      "queryid": "400000000"
    };
    Uri url = Uri.https("opengtindb.org", "/", params);
    Response response = await http.post(url);

    if (!response.body.contains("error=0")){
      BarcodeNotFoundAlertWidget.showModal(context);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BarcodeItemDetailPage(responseBody: response.body)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Row(
          children: [
            const Icon(FontAwesomeIcons.barcode, size: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(Languages.of(context)!.barcodeButtonText),
            )
          ],
        ),
        onPressed: _scanBarcodeNormal,
    );
  }
}
