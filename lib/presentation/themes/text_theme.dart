import 'package:flutter/material.dart';

class AppTextTheme extends TextTheme{

  const AppTextTheme() : super(
    headline1: const TextStyle(
      fontFamily: "Asap",
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    headline2: const TextStyle(
      fontFamily: "Asap",
      fontSize: 17.0,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    headline3: const TextStyle(
      fontFamily: "Asap",
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    bodyText1: const TextStyle(
      fontFamily: "Asap",
      fontSize: 14.0,
    ),
    bodyText2: const TextStyle(
      fontFamily: "Asap",
      fontSize: 16.0,
    ),
    labelMedium: const TextStyle(
      fontFamily: "Asap",
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
    button: const TextStyle(
      fontFamily: "Asap",
      fontSize: 13.0,
    ),
  );

}