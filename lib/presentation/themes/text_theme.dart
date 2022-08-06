import 'package:flutter/material.dart';

class AppTextTheme extends TextTheme{

  //TODO
  const AppTextTheme() : super(
    headline1: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
    headline2: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
    headline3: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
    subtitle1: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
    subtitle2: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
    bodyText1: const TextStyle(fontSize: 14.0),
    bodyText2: const TextStyle(fontSize: 13.0),
    button: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
    caption: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold)
  );

}