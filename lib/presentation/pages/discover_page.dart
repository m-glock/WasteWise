import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Languages.of(context)!.discoveryPageName),
      ),
    );
  }
}