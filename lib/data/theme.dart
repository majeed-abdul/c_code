import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {
  static ThemeData lightThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFD42027),
        background: Colors.white,
        error: Colors.red,
        onTertiary: Colors.orange,
      ),
      filledButtonTheme: const FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            Color(0xFFD42027),
          ),
        ),
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        color: Color(0xFFD42027),
        elevation: 5,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0xFFD42027),
      ),
      dialogTheme: const DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          actionsPadding: EdgeInsets.all(15),
          surfaceTintColor: Colors.white),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(8),
        hintStyle: TextStyle(fontSize: 15),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Color(0xFFD42027), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Color(0xff999999), width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Color(0xff999999), width: 1.0),
        ),
      ),
      iconTheme:
          const IconThemeData(color: Color(0xFFD42027)), // icon color below
      listTileTheme:
          const ListTileThemeData(iconColor: Color(0xFFD42027)), //same
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFD42027),
        foregroundColor: Colors.white,
        // shape: CircleBorder(),
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
