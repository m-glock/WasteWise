import 'package:flutter/material.dart';

class AppColorScheme extends ColorScheme{

  //TODO
  const AppColorScheme() : super(
    background: const Color.fromARGB(255, 254, 255, 245),
    onPrimary: const Color.fromARGB(255, 50, 50, 50),
    onError: const Color.fromARGB(255, 50, 50, 50),
    onSecondary: const Color.fromARGB(255, 50, 50, 50),
    secondary: const Color.fromARGB(255, 170, 239, 223),
    surface: const Color.fromARGB(255, 245, 245, 245),
    primaryVariant: const Color.fromARGB(255, 129, 153, 67),
    primary: const Color.fromARGB(255, 189, 224, 99),
    error: const Color.fromARGB(255, 213, 76, 76),
    onSurface: const Color.fromARGB(255, 50, 50, 50),
    secondaryVariant: const Color.fromARGB(255, 109, 153, 142),
    onBackground: const Color.fromARGB(255, 50, 50, 50),
    brightness: Brightness.light,
  );

}