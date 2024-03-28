import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_maze/functions/ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:qr_maze/widgets/loader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((pref) {
      int i = pref.getInt('home') ?? 0;
      if (i == 1) {
        _home = 'Create';
      } else {
        _home = 'Scan';
      }
      setState(() {});
    });
    // PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    //   appName = packageInfo.appName;
    //   version = packageInfo.version;
    //   setState(() {});
    // });
    // print('===init');
    context.read<AdLoader>().loaderOff();
  }

  // @override
  // void dispose() {
  //   print('===dispose');
  //   context.read<AdLoader>().loaderOff();
  //   super.dispose();
  // }

  // @override
  // void didChangeDependencies() {
  //   print('===didChange');
  //   super.didChangeDependencies();
  // }

  String? _home;
  final InAppReview inAppReview = InAppReview.instance;

  // String? appName;
  // String? version;

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
              // const Divider(),
              // const Text('  App', style: TextStyle(color: Colors.black54)),
              // ListTile(
              //   title: Text(appName ?? 'null'),
              //   subtitle: Text('version: $version'),
              //   leading: const Icon(Icons.adb, size: 40),
              // ),
              // const Divider(),
              const SizedBox(height: 5),
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
                title: const Text('Rating'),
                subtitle: const Text('Rate us on Play Store.'),
                leading: const Icon(Icons.star_rate_rounded, size: 40),
                trailing: const Icon(Icons.more_vert),
                onTap: () async {
                  String id = 'com.abdul.qr_maze';
                  // if (await inAppReview.isAvailable()) {
                  // inAppReview.requestReview();
                  // } else {
                  // debugPrint('====in_App_Review_Not_Available');
                  inAppReview.openStoreListing(appStoreId: id);
                  // }
                },
              ),
              ListTile(
                title: const Text('Donate ❤️'),
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
                onTap: () {
                  loadAndShowAd(context);
                },
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
      bool i = pref.getInt('home') == 0 ? true : false;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          actionsAlignment: MainAxisAlignment.center,
          title: const Text('Set Home Screen', textAlign: TextAlign.center),
          titlePadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          actionsPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          content: const Text(
            'This screen will apear on app start up. Default screen is "Create"',
          ),
          actions: [
            Column(
              children: [
                ListTile(
                  minVerticalPadding: 0,
                  minLeadingWidth: 0,
                  leading: Icon(
                    i ? Icons.radio_button_checked : Icons.radio_button_off,
                    color: i ? Theme.of(context).primaryColor : null,
                  ),
                  title: const Text('Scan'),
                  onTap: () async {
                    await pref.setInt('home', 0).then((value) {
                      _home = 'Scan';
                      setState(() {});
                      Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  minVerticalPadding: 0,
                  minLeadingWidth: 0,
                  leading: Icon(
                    i ? Icons.radio_button_off : Icons.radio_button_checked,
                    color: i ? null : Theme.of(context).primaryColor,
                  ),
                  title: const Text('Create'),
                  onTap: () async {
                    await pref.setInt('home', 1).then((value) {
                      _home = 'Create';
                      setState(() {});
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await pref.setInt('home', 0).then((value) {
            //       _home = 'Create';
            //       setState(() {});
            //       Navigator.pop(context);
            //     });
            //   },
            //   child: const Padding(
            //     padding: EdgeInsets.all(11),
            //     child: Text('Create'),
            //   ),
            // ),//////////////////////////////         OLD
            // const Text('OR'),
            // ElevatedButton(
            //   onPressed: () async {
            //     await pref.setInt('home', 1).then((value) {
            //       _home = 'Scan';
            //       setState(() {});
            //       Navigator.pop(context);
            //     });
            //   },
            //   child: const Padding(
            //     padding: EdgeInsets.all(11),
            //     child: Text('Scan'),
            //   ),
            // ),
          ],
        ),
      );
    });
  }
}
