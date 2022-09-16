import 'package:flutter/material.dart';

class AppTextTheme extends TextTheme{

  const AppTextTheme() : super(
    headline1: const TextStyle(
      fontFamily: "Asap",
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: const TextStyle(
      fontFamily: "Asap",
      fontSize: 18.0,
      fontStyle: FontStyle.italic,
    ),
    headline3: const TextStyle(
      fontFamily: "Asap",
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 84, 84, 84),
    ),
    bodyText1: const TextStyle(
      fontFamily: "Asap",
      fontSize: 14.0,
    ),
    labelMedium: const TextStyle(
      fontFamily: "Asap",
      fontSize: 15.0,
    ),
    button: const TextStyle(
      fontFamily: "Asap",
      fontSize: 13.0,
    ),
  );

}