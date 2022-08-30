import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:http/http.dart' as http;
import 'package:recycling_app/presentation/pages/search/item_detail_page.dart';
import 'package:recycling_app/presentation/util/BarcodeResult.dart';
import 'package:recycling_app/presentation/util/database_classes/item.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
    http.Response response = await http.post(url);
    Item? item = BarcodeResult.getItemFromBarcodeInfo(response.body);
    if (item != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ItemDetailPage(item: item)),
      );
    } else {
      showDialog(
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
        onPressed: _scanBarcodeNormal,
      ),
    );
  }
}
