import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class ImprintPage extends StatefulWidget {
  const ImprintPage({Key? key}) : super(key: key);

  @override
  State<ImprintPage> createState() => _ImprintPageState();
}

class _ImprintPageState extends State<ImprintPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.imprintPageName),
      ),
      body: const Center(),
    );
  }
}