import 'package:c_code/data/provider.dart';
import 'package:c_code/screens/home.dart';
import 'package:c_code/screens/scan.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CreateProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          // primarySwatch: Colors.red,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
            onTertiary: Colors.amber,
          ),
          useMaterial3: true,
        ),
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          ScanScreen.id: (context) => const ScanScreen()
        },
      ),
    );
  }
}
