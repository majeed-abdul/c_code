import 'package:qr_maze/functions/ads.dart';
import 'package:provider/provider.dart';
import 'package:qr_maze/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:qr_maze/screens/scan.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AdLoader()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        ScanScreen.id: (context) => const ScanScreen(),
      },
      theme: ThemeData(
        useMaterial3: false,
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
    );
  }
}
