import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightThemeData() {
    return ThemeData(
      // colorSchemeSeed: Colors.red,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFFF4040),
        background: Colors.white,
        error: Colors.red,
        onTertiary: Colors.orange,
      ),
      filledButtonTheme: const FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            Color(0xFFFF4040),
          ),
        ),
      ),
      useMaterial3: true,
      // navigationBarTheme: const NavigationBarThemeData(
      //   iconTheme: MaterialStatePropertyAll(IconThemeData(color: Colors.amber)),
      // ),
      appBarTheme: const AppBarTheme(
        color: Colors.red,
        // shadowColor: Colors.red,
        elevation: 5,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: Colors.red),
      ),
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
