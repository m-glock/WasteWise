import 'package:flutter/material.dart';

class AppElevatedButtonTheme extends ElevatedButtonThemeData{

  AppElevatedButtonTheme() : super(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
            const TextStyle(fontWeight: FontWeight.bold)
        ),
        elevation: MaterialStateProperty.all(2),
        shadowColor: MaterialStateProperty.all(Colors.black54)
      )
  );

}

class AppFloatingActionButtonTheme extends FloatingActionButtonThemeData{

  //TODO
  const AppFloatingActionButtonTheme() : super(

  );

}

class AppOutlinedButtonTheme extends OutlinedButtonThemeData{

  AppOutlinedButtonTheme() : super(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
            const TextStyle(fontWeight: FontWeight.bold)
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.all(2),
        shadowColor: MaterialStateProperty.all(Colors.black54)
        //side: MaterialStateProperty.all(BorderSide(color: Colors.blue)),
      )
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