import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class TipsAndTricksPage extends StatefulWidget {
  const TipsAndTricksPage({Key? key}) : super(key: key);

  @override
  State<TipsAndTricksPage> createState() => _TipsAndTricksPageState();
}

class _TipsAndTricksPageState extends State<TipsAndTricksPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.tipsAndTricksTitle),
      ),
      body: const Center(
        child: Text("Body"),
      ),
    );
  }
}