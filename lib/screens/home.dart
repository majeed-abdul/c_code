// import 'package:flutter/services.dart';
// import 'package:qr_maze/main.dart';
import 'package:qr_maze/screens/history.dart';
// import 'package:quick_settings/quick_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_maze/screens/create.dart';
import 'package:qr_maze/screens/info.dart';
import 'package:qr_maze/screens/scan.dart';
import 'package:flutter/material.dart';
// import 'package:app_launcher/app_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = 'homeScreen/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _index = 0;
// late Widget bodyWidget;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SharedPreferences.getInstance().then((pref) {
      _index = pref.getInt('home') ?? 0;
      setState(() {});
    });
    pageController = PageController(initialPage: _index);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    // switch (_index) {
    //   case 0:
    //     bodyWidget = const ScanScreen();
    //     break;
    //   case 1:
    //     bodyWidget = const CreateScreen();
    //     break;
    //   case 2:
    //     bodyWidget = const History();
    //     break;
    //   case 3:
    //     bodyWidget = const InfoScreen();
    //     break;
    // }
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (_index != 0) {
          pageController.jumpToPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: (i) => setState(() => _index = i),
          children: const [
            ScanScreen(),
            CreateScreen(),
            History(),
            InfoScreen(),
          ],
        ),

        //
        //
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.add),
        //   // backgroundColor: Theme.of(context).primaryColorDark,
        //   onPressed: () {
        //     // ContactsService.openContactForm();1

        //     // await ContactsService.addContact(
        //     //   Contact(
        //     //     displayName: 'majeed',
        //     //     phones: [
        //     //       Item(label: 'mobile', value: '076434676'),
        //     //     ],
        //     //   ),
        //     // );//2

        //     //         if (Platform.isAndroid) {
        //     // final AndroidIntent intent = AndroidIntent(
        //     //   action: 'ContactsContract.Intents.Insert.ACTION',
        //     //   category: 'ContactsContract.RawContacts.CONTENT_TYPE',
        //     // );
        //     // await intent.launch();
        //     //}  //3

        //     // ContactsService.openExistingContact(
        //     //   Contact(
        //     //     displayName: 'aaaa',
        //     //     phones: [
        //     //       Item(label: 'Mobile', value: '097643'),
        //     //     ],
        //     //   ),
        //     // ).then((value) => print('======= tappp'));4
        //   },
        // ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     try {
        //       // Obtain SSID and password from user input or any other source
        //       String ssid = '723129';
        //       String password = '12341234';
        //       // );
        //       await WiFiForIoTPlugin.registerWifiNetwork(
        //         ssid,
        //         password: password,///////////   ✅ WIFI REGISTER TESTING ✅
        //         security: NetworkSecurity.WPA,
        //       );
        //       // print('Connected to Wi-Fi: $ssid');
        //     } catch (e) {
        //       print('Error connecting to Wi-Fi: $e');
        //     }
        //   },
        //   child: const Icon(Icons.connect_without_contact_outlined),
        // ),// 4
        // floatingActionButton: FloatingActionButton(onPressed: () async {
        //   await Permission.nearbyWifiDevices.request();
        //   String ssid = '7237';
        //   String password = '12341234';
        //   if (ssid.isEmpty) {
        //     throw ("SSID can't be empty");
        //   }
        //   if (password.isEmpty) {
        //     throw ("Password can't be empty");
        //   }
        //   debugPrint('Ssid: $ssid, Password: $password');

        //   ///Return boolean value
        //   ///If true then connection is success
        //   ///If false then connection failed due to authentication
        //   var result = await AndroidFlutterWifi.connectToNetwork(ssid, password);

        //   debugPrint(
        //       '---------Connection result-----------: ${result.toString()}');
        // }),//.. 5
        //
        //
        //===========================================================
        //
        //

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // await AppLauncher.openApp(
        //     //   //// TEST  ////
        //     //   androidApplicationId: "com.abdul.qr_maze",
        //     // );
        //     // QuickSettingsHelper.openQuickSettings();
        //   },
        // ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          currentIndex: _index,
          onTap: (i) => pageController.jumpToPage(i),
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            // color: Colors.amber,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.center_focus_weak),
              activeIcon: Icon(Icons.center_focus_strong),
              label: 'Scan',
              tooltip: 'Scan QR',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: 'Create',
              tooltip: 'Create QR',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              activeIcon: Icon(Icons.history),
              label: 'History',
              tooltip: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              activeIcon: Icon(Icons.info),
              label: 'About',
              tooltip: 'About',
            ),
          ],
        ),
      ),
    );
  }

  // static Future<bool?> openApp() async {
  //   return await methodChannel.invokeMethod<bool>("getOpenApp");
  // }
}
