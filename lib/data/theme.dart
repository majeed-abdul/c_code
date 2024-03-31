import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {
  static ThemeData lightThemeData() {
    return ThemeData(
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
      appBarTheme: const AppBarTheme(
        color: Colors.red,
        elevation: 5,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.red,
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
          borderSide: BorderSide(color: Colors.red, width: 1.0),
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
      iconTheme: const IconThemeData(color: Colors.red), // icon color below
      listTileTheme: const ListTileThemeData(iconColor: Colors.red), //same
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
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
