import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightThemeData() {
    return ThemeData(
      // colorSchemeSeed: Colors.red,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.red,
        background: Colors.white,
        error: Colors.red,
        onTertiary: Colors.orange,
      ),
      filledButtonTheme: const FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            Colors.red,
          ),
        ),
      ),
      useMaterial3: true,
      // navigationBarTheme: const NavigationBarThemeData(
      //   iconTheme: MaterialStatePropertyAll(IconThemeData(color: Colors.amber)),
      // ),
      appBarTheme: const AppBarTheme(
        color: Colors.red,
        elevation: 5,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: Colors.red),
        selectedItemColor: Colors.amber,
        selectedLabelStyle: TextStyle(backgroundColor: Colors.amber),
        // showSelectedLabels: fals,
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
