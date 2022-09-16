import 'package:flutter/material.dart';

class AppElevatedButtonTheme extends ElevatedButtonThemeData{

  //TODO
  const AppElevatedButtonTheme() : super(

  );

}

class AppFloatingActionButtonTheme extends FloatingActionButtonThemeData{

  //TODO
  const AppFloatingActionButtonTheme() : super(

  );

}

class AppOutlinedButtonTheme extends OutlinedButtonThemeData{

  //TODO
  const AppOutlinedButtonTheme() : super(

  );

}

class AppTextButtonTheme extends TextButtonThemeData{

  AppTextButtonTheme() : super(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
      textStyle: MaterialStateProperty.all(
          const TextStyle(fontWeight: FontWeight.bold)
      ),
    )
  );

}