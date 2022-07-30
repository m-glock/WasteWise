import 'package:flutter/material.dart';

class NeighborhoodPage extends StatefulWidget {
  const NeighborhoodPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NeighborhoodPage> createState() => _NeighborhoodPageState();
}

class _NeighborhoodPageState extends State<NeighborhoodPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Neighborhood"),
      ),
    );
  }
}