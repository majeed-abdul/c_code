import 'package:c_code/functions/ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:c_code/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
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

  String? _home;
  String? appName;
  String? version;

  @override
  Widget build(BuildContext context) {
    return Spinner(
      spinning: context.watch<AdLoader>().loader,
      child: Scaffold(
        appBar: AppBar(title: const Text('About'), centerTitle: true),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const Text('  App', style: TextStyle(color: Colors.black54)),
              ListTile(
                title: Text(appName ?? 'null'),
                subtitle: Text('version: $version'),
                leading: const Icon(Icons.adb, size: 40),
              ),
              const Divider(),
              const Text('  Setting', style: TextStyle(color: Colors.black54)),
              ListTile(
                title: const Text('Home Screen'),
                subtitle: Text(_home ?? ''),
                leading: const Icon(Icons.home_rounded, size: 40),
                trailing: const Icon(Icons.more_vert),
                onTap: () => setHomePage(context),
              ),
              const Divider(),
              const Text('  Support', style: TextStyle(color: Colors.black54)),
              ListTile(
                title: const Text('Donate'),
                subtitle: const Text('We need support to keep you up to date.'),
                leading: const Icon(Icons.volunteer_activism_rounded, size: 40),
                trailing: const Icon(Icons.more_vert),
                onTap: () => donate(context),
              ),
              ListTile(
                title: const Text('Support (See ads)'),
                subtitle: const Text('Support us by watching Ads.'),
                leading: const Icon(Icons.ads_click, size: 40),
                trailing: const Icon(Icons.more_vert),
                onTap: () => loadAndShowAd(context),
              ),
              const Divider(),
              const SizedBox(height: 20),
              Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () async {
                    Uri url = Uri.parse(
                      'https://qrscancreate.blogspot.com/2024/01/privacy-policy-for-qr-scancreate.html',
                    );
                    launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> setHomePage(BuildContext context) async {
    await SharedPreferences.getInstance().then((pref) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text('Set Home Screen', textAlign: TextAlign.center),
          titlePadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          content: const Text(
            'This screen will apear on app start up. Default screen is "Create"',
          ),
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
