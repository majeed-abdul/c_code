import 'package:c_code/screens/create.dart';
import 'package:c_code/screens/scan.dart';
import 'package:c_code/screens/info.dart';
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
          color: Colors.amber,
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
            label: 'Info',
            tooltip: 'Information',
          ),
        ],
      ),
    );
  }
}
