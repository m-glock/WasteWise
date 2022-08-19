import 'package:flutter/material.dart';

import '../util/constants.dart';

class NeighborhoodPage extends StatefulWidget {
  const NeighborhoodPage({Key? key}) : super(key: key);

  @override
  State<NeighborhoodPage> createState() => _NeighborhoodPageState();
}

class _NeighborhoodPageState extends State<NeighborhoodPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Constants.pagePadding),
        child: const Center(
          child: Text("Neighborhood"),
        ),
      ),
    );
  }
}