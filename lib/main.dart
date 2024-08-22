// import 'package:app_launcher/app_launcher.dart';
import 'package:qr_maze/data/hive/model.dart';
import 'package:qr_maze/data/theme.dart';
import 'package:qr_maze/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:qr_maze/screens/scan.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:quick_settings/quick_settings.dart';
// import 'package:flutter/services.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ScannedDataAdapter());
  await Hive.openBox<ScannedData>('scannedCodes');
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // QuickSettings.setup(
  //   onTileClicked: onTileClicked,
  //   onTileAdded: onTileAdded,
  //   onTileRemoved: onTileRemoved,
  // );
  // QuickSettings.addTileToQuickSettings(
  //   label: 'QR Scanner',
  //   drawableName: 'scanner_launch',
  // );
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
    // FocusManager.instance.primaryFocus?.dispose();

    // FocusScope.of(context).unfocus(); //  For Keyboard Dismis
    // FocusScope.of(context).; //  For Keyboard Dismis

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



// @pragma("vm:entry-point")
// Tile onTileClicked(Tile tile) {
//   // final oldStatus = tile.tileStatus;
//   // if (oldStatus == TileStatus.active) {
//   // Tile has been clicked while it was active
//   // Set it to inactive and change its values accordingly
//   // Here: Disable the alarm
//   // tile.label = "Alarm OFF";
//   // tile.tileStatus = TileStatus.inactive;
//   // tile.subtitle = "6:30 AM";
//   // tile.drawableName = "alarm_off";
//   // AlarmManager.instance.unscheduleAlarm();
//   // } else {
//   //   // Tile has been clicked while it was inactive
//   //   // Set it to active and change its values accordingly
//   //   // Here: Enable the alarm
//   //   tile.label = "Alarm ON";
//   //   tile.tileStatus = TileStatus.inactive;
//   //   // tile.subtitle = "6:30 AM";
//   //   // tile.drawableName = "alarm_check";
//   //   // AlarmManager.instance.scheduleAlarm();
//   // }
//   // Return the updated tile, or null if you don't want to update the tile
//   print("====---- Tile Clicked");
//   // platform.invokeMethod('getOpenApp');
//   AppLauncher.openApp(
//     androidApplicationId: 'com.abdul.qr_maze',
//   );

//   return tile;
// }

// @pragma("vm:entry-point")
// Tile onTileAdded(Tile tile) {
//   print("==== Tile Added");
//   tile.label = "QR Scanner";
//   tile.tileStatus = TileStatus.inactive;
//   // tile.subtitle = "6:30 AM";
//   tile.drawableName = "scanner_launch";
//   // AlarmManager.instance.scheduleAlarm();

//   return tile;
// }

// @pragma("vm:entry-point")
// void onTileRemoved() {
//   print("==== Tile removed");
//   // AlarmManager.instance.unscheduleAlarm();
// }
