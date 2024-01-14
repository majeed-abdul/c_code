import 'package:c_code/screens/create.dart';
import 'package:c_code/screens/info.dart';
import 'package:c_code/screens/scan.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _index = 0;
late Widget bodyWidget;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SharedPreferences.getInstance().then((pref) {
      _index = pref.getInt('home') ?? 0;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_index) {
      case 0:
        bodyWidget = const CreateScreen();
        break;
      case 1:
        bodyWidget = const ScanScreen();
        break;
      case 2:
        bodyWidget = const InfoScreen();
        break;
    }
    return Scaffold(
      body: bodyWidget,
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
      //     // );2

      //     //         if (Platform.isAndroid) {
      //     // final AndroidIntent intent = AndroidIntent(
      //     //   action: 'ContactsContract.Intents.Insert.ACTION',
      //     //   category: 'ContactsContract.RawContacts.CONTENT_TYPE',
      //     // );
      //     // await intent.launch();
      //     //} 3

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
      // ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _index,
        elevation: 25,
        onTap: (i) => setState(() => _index = i),
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          // color: Colors.amber,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            activeIcon: Icon(Icons.add_box),
            label: 'Create',
            tooltip: 'Create QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.center_focus_weak),
            activeIcon: Icon(Icons.center_focus_strong),
            label: 'Scan',
            tooltip: 'Scan QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            activeIcon: Icon(Icons.info),
            label: 'About',
            tooltip: 'About',
          ),
        ],
      ),
    );
  }
}
