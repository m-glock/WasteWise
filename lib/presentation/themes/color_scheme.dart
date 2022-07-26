import 'package:flutter/material.dart';

class AppColorScheme extends ColorScheme{

  const AppColorScheme() : super(
    background: const Color.fromARGB(255, 250, 255, 248),
    onPrimary: const Color.fromARGB(255, 245, 242, 241),
    onError: const Color.fromARGB(255, 238, 238, 238),
    onSecondary: const Color.fromARGB(255, 241, 240, 238),
    secondary: const Color.fromARGB(255, 140, 108, 48),
    surface: const Color.fromARGB(255, 236, 232, 221),
    primary: const Color.fromARGB(255, 120, 155, 96),
    tertiary: const Color.fromARGB(255, 197, 173, 125),
    error: const Color.fromARGB(255, 213, 76, 76),
    onSurface: const Color.fromARGB(255, 50, 50, 50),
    onBackground: const Color.fromARGB(255, 50, 50, 50),
    brightness: Brightness.light,
  );

}