import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Languages.of(context)!.homePageName),
      ),
    );
  }
}