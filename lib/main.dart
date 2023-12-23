import 'package:c_code/functions/ads.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:c_code/screens/home.dart';
import 'package:c_code/screens/scan.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  return runApp(
    MultiProvider(
      providers: [Provider<Ads>(create: (_) => Ads())],
      child: const MyApp(),
    ),
  );
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
    );
  }
}
// import 'package:c_code/widgets/loader.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].

// void main() {
//   runApp(
//     /// Providers are above [MyApp] instead of inside it, so that tests
//     /// can use [MyApp] while mocking the providers
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => Counter()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class Counter extends ChangeNotifier {
//   bool load = false;

//   void increment() {
//     load = !load;
//     notifyListeners();
//   }

//   /// Makes `Counter` readable inside the devtools by listing all of its properties
//   // @override
//   // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//   //   super.debugFillProperties(properties);
//   //   properties.add(IntProperty('count', count));
//   // }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Spinner(
//       spinning: context.watch<Counter>().load,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Example'),
//         ),
//         body: const Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text('You have pushed the button this many times:'),

//               /// Extracted as a separate widget for performance optimization.
//               /// As a separate widget, it will rebuild independently from [MyHomePage].
//               ///
//               /// This is totally optional (and rarely needed).
//               /// Similarly, we could also use [Consumer] or [Selector].
//               // Count(),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           key: const Key('increment_floatingActionButton'),

//           /// Calls `context.read` instead of `context.watch` so that it does not rebuild
//           /// when [Counter] changes.
//           onPressed: () => context.read<Counter>().increment(),
//           tooltip: 'Increment',
//           child: const Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }

// // class Count extends StatelessWidget {
// //   const Count({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Text(
// //       /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
// //       '${context.watch<Counter>().load}',
// //       key: const Key('counterState'),
// //       style: Theme.of(context).textTheme.headlineMedium,
// //     );
//   // }
// // }
