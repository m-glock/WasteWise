import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Dashboard"),
      ),
    );
  }
}