import 'package:package_info_plus/package_info_plus.dart';
import 'package:qr_maze/widgets/pop_ups.dart';
import 'package:qr_maze/widgets/support_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_maze/functions/ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:qr_maze/widgets/loader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    updatePopUp();
    SharedPreferences.getInstance().then((pref) {
      int i = pref.getInt('home') ?? 0;
      if (i == 1) {
        _home = 'Create';
      } else {
        _home = 'Scan';
      }
      setState(() {});
    });
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      version = packageInfo.version;
      setState(() {});
    });
    context.read<AdLoader>().loaderOff();
    super.initState();
  }

  String? _home;
  final InAppReview inAppReview = InAppReview.instance;

  String? appName;
  String? version;

  @override
  Widget build(BuildContext context) {
    return Spinner(
      spinning: context.watch<AdLoader>().loader,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('About'),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              const Text('  Setting', style: TextStyle(color: Colors.black54)),
              homeScreen(context),
              const Divider(),
              const Text('  Support', style: TextStyle(color: Colors.black54)),
              rating(),
              joinBeta(),
              shareApp(context),
              donatePop(context),
              seeAds(context),
              const Divider(),
              const Text('  App', style: TextStyle(color: Colors.black54)),
              appInfo(), //  true = beta version ====================
              const Divider(),
              const SizedBox(height: 20),
              privacyPolicyButton(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

//

//

//                  E X T R A S

//

//

  ListTile appInfo() {
    return ListTile(
      iconColor: Colors.black54,
      title: Text('$appName'),
      subtitle: Text('version: $version'),
      leading: const Icon(Icons.adb, size: 40),
    );
  }

  ListTile joinBeta() {
    return ListTile(
      iconColor: Colors.black54,
      title: const Text('Join Beta'),
      subtitle: const Text('Join testers, Early access to new features.'),
      leading: const Icon(Icons.bug_report, size: 40),
      trailing: const Icon(Icons.more_vert),
      onTap: () {
        joinBetaPopUp(context);
        // Uri url = Uri.parse(
        //   'https://play.google.com/store/apps/details?id=com.abdul.qr_maze',
        // );
        // launchUrl(url, mode: LaunchMode.externalApplication);
      },
    );
  }

  ListTile rating() {
    return ListTile(
      iconColor: Colors.black54,
      title: const Text('Rating'),
      subtitle: const Text('Rate us on Play Store.'),
      leading: const Icon(Icons.star_rate_rounded, size: 40),
      trailing: const Icon(Icons.more_vert),
      onTap: () async {
        // if (await inAppReview.isAvailable()) {
        //   print('=================true');
        //   // });
        //   inAppReview.requestReview();
        // } else {
        String id = 'com.abdul.qr_maze';
        // print('=================false');
        StoreRedirect.redirect(androidAppId: id);
        // }
      },
    );
  }

  ListTile homeScreen(BuildContext context) {
    return ListTile(
      iconColor: Colors.black54,
      title: const Text('Home Screen'),
      subtitle: Text(_home ?? ''),
      leading: const Icon(Icons.home_rounded, size: 40),
      trailing: const Icon(Icons.more_vert),
      onTap: () => setHomePage(context),
    );
  }

  Center privacyPolicyButton() {
    return Center(
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
    );
  }

  Future<dynamic> setHomePage(BuildContext context) async {
    await SharedPreferences.getInstance().then((pref) {
      bool i = pref.getInt('home') == 0 ? true : false;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text('Set Home Screen', textAlign: TextAlign.center),
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
                  leading: i
                      ? const Icon(Icons.radio_button_checked)
                      : const Icon(
                          Icons.radio_button_off,
                          color: Colors.black54,
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
                  leading: i
                      ? const Icon(
                          Icons.radio_button_off,
                          color: Colors.black54,
                        )
                      : const Icon(
                          Icons.radio_button_checked,
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
            // ),
          ],
        ),
      );
    });
  }
}
