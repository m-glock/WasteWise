import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/util/waste_bin.dart';

class WasteBinPage extends StatefulWidget {
  const WasteBinPage({Key? key, required this.wasteBin}) : super(key: key);

  final WasteBin wasteBin;

  @override
  State<WasteBinPage> createState() => _WasteBinPageState();
}

class _WasteBinPageState extends State<WasteBinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.wasteBinNames[widget.wasteBin] ?? "Unknown"),
      ),
      body: const Center(
        child: Text("Body"),
      ),
    );
  }
}