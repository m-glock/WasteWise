import 'package:flutter/material.dart';

abstract class Languages {

  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get homePageName;
  String get searchPageName;
  String get discoveryPageName;
  String get neighborhoodPageName;
}