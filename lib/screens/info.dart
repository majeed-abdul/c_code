import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String? _home;
  @override
  void initState() {
    SharedPreferences.getInstance().then((pref) {
      int i = pref.getInt('home') ?? 0;
      if (i == 1) {
        _home = 'Scan';
      } else {
        _home = 'Create';
      }
    });
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      version = packageInfo.version;
      setState(() {});
    });
    super.initState();
  }

  @override
  void reassemble() {
    SharedPreferences.getInstance().then((pref) {
      int i = pref.getInt('home') ?? 0;
      if (i == 1) {
        _home = 'Scan';
      } else {
        _home = 'Create';
      }
      setState(() {});
    });
    super.reassemble();
  }

  String? appName;
  String? version;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(appName ?? 'null'),
              subtitle: Text('version: $version'),
              leading: const Icon(
                Icons.file_download_rounded,
                size: 40,
              ),
            ),
            ListTile(
              title: const Text('Home Screen'),
              subtitle: Text(_home ?? ''),
              leading: const Icon(
                Icons.home_rounded,
                size: 40,
              ),
              trailing: const Icon(Icons.more_vert),
              onTap: () {
                setHomePage(context);
              },
            ),
          ],
        ),
      ),
    );
  }

//

//

//                  E X T R A S

//

//

  Future<dynamic> setHomePage(BuildContext context) async {
    await SharedPreferences.getInstance().then((pref) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text(
            'Set Home Screen',
            textAlign: TextAlign.center,
          ),
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          content: const Text(
              'This screen will apear on app start up. Default screen is "Create"'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await pref.setInt('home', 0).then((value) {
                  _home = 'Create';
                  setState(() {});
                  Navigator.pop(context);
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(11),
                child: Text('Create'),
              ),
            ),
            const Text('OR'),
            ElevatedButton(
              onPressed: () async {
                await pref.setInt('home', 1).then((value) {
                  _home = 'Scan';
                  setState(() {});
                  Navigator.pop(context);
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(11),
                child: Text('Scan'),
              ),
            ),
          ],
        ),
      );
    });
  }
}
