import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {
  static ThemeData lightThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFD42027),
        // background: Colors.white,
        error: Colors.red,
        onTertiary: Colors.orange,
      ),
      filledButtonTheme: const FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Color(0xFFD42027),
          ),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
        shadowColor: Colors.black,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
        titleTextStyle: TextStyle(
            color: Color(0xFFD42027),
            fontSize: 22, //default
            fontWeight: FontWeight.w500),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFFD42027),
          elevation: 25,
          type: BottomNavigationBarType.fixed),
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
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: Colors.white,
        showDragHandle: true,
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
