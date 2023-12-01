import 'package:c_code/screens/home.dart';
import 'package:c_code/screens/scan.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFF4040),
        ),
        primarySwatch: const MaterialColor(0xFFFF4040, {
          050: Color.fromRGBO(212, 32, 39, .1),
          100: Color.fromRGBO(212, 32, 39, .2),
          200: Color.fromRGBO(212, 32, 39, .3),
          300: Color.fromRGBO(212, 32, 39, .4),
          400: Color.fromRGBO(212, 32, 39, .5),
          500: Color.fromRGBO(212, 32, 39, .6),
          600: Color.fromRGBO(212, 32, 39, .7),
          700: Color.fromRGBO(212, 32, 39, .8),
          800: Color.fromRGBO(212, 32, 39, .9),
          900: Color.fromRGBO(212, 32, 39, 1),
        }),
      ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        ScanScreen.id: (context) => const ScanScreen()
      },
      // ),
    );
  }
}
