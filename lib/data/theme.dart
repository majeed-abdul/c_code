import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightThemeData() {
    return ThemeData(
      // colorSchemeSeed: Colors.red,
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          background: Colors.white,
          error: Colors.red,
          onTertiary: Colors.orange),
      useMaterial3: true,
    );
  }

  static ThemeData darkThemeData() {
    return ThemeData(
      // colorSchemeSeed : ....,
      // fontFamily: ...,
      // colorScheme : ...,
      // appBarTheme : ...,
      // hoverColor : ...,
      // cardTheme : ...,
      // textTheme : ...,
      // elevatedButtonTheme : ...,
      useMaterial3: true,
    );
  }
}
