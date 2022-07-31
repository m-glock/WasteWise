import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class NeighborhoodPage extends StatefulWidget {
  const NeighborhoodPage({Key? key}) : super(key: key);

  @override
  State<NeighborhoodPage> createState() => _NeighborhoodPageState();
}

class _NeighborhoodPageState extends State<NeighborhoodPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Languages.of(context)!.neighborhoodPageName),
      ),
    );
  }
}