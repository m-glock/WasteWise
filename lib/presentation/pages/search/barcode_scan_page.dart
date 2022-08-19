import 'package:flutter/material.dart';

class BarcodeScanPage extends StatefulWidget {
  const BarcodeScanPage({Key? key}) : super(key: key);

  @override
  State<BarcodeScanPage> createState() => _BarcodeScanPageState();
}

class _BarcodeScanPageState extends State<BarcodeScanPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Barcode"),
      ),
      body: const Center(),
    );
  }
}