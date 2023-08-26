import 'package:c_code/screens/create.dart';
import 'package:c_code/screens/scan.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    switch (_index) {
      case 0:
        bodyWidget = const CreateScreen();
        break;
      case 1:
        bodyWidget = const ScanScreen();
        break;
    }
    return Scaffold(
      body: bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 25,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (i) {
          _index = i;
          setState(() {});
        },
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.amber,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
        ],
      ),
    );
  }
}
