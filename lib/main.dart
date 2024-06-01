import 'package:qr_maze/data/hive/model.dart';
import 'package:qr_maze/data/theme.dart';
import 'package:qr_maze/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:qr_maze/screens/scan.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ScannedDataAdapter());
  await Hive.openBox<ScannedData>('scannedCodes');
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  return runApp(
      // MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider(create: (_) => AdLoader()),
      //   ],
      // child: const MyApp(),
      // ),
      // );
      const MyApp()); //only for without provider
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
      theme: CustomTheme.lightThemeData(),
      // darkTheme: CustomTheme.darkThemeData(),
      // theme: ThemeData(
      //   appBarTheme: const AppBarTheme(
      //     systemOverlayStyle: SystemUiOverlayStyle(
      //       statusBarColor: Colors.black,
      //     ),
      //   ),
      //   floatingActionButtonTheme: const FloatingActionButtonThemeData(
      //     backgroundColor: Color(0xFFFF4040),
      //   ),

      // primarySwatch: const MaterialColor(0xFFFF4040, {
      //   050: Color.fromRGBO(212, 32, 39, .1),
      //   100: Color.fromRGBO(212, 32, 39, .2),
      //   200: Color.fromRGBO(212, 32, 39, .3),
      //   300: Color.fromRGBO(212, 32, 39, .4),
      //   400: Color.fromRGBO(212, 32, 39, .5),
      //   500: Color.fromRGBO(212, 32, 39, .6),
      //   600: Color.fromRGBO(212, 32, 39, .7),
      //   700: Color.fromRGBO(212, 32, 39, .8),
      //   800: Color.fromRGBO(212, 32, 39, .9),
      //   900: Color.fromRGBO(212, 32, 39, 1),
      // }),
      // ),
    );
  }
}
