import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Discover"),
      ),
    );
  }
}