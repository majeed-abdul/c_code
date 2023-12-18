import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:c_code/widgets/pop_ups.dart';
import 'package:c_code/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool loading = false;
  bool rewarded = false;
  final adUnitId = 'ca-app-pub-9338573690135257/6850625011';
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

  String? appName;
  String? version;
  @override
  Widget build(BuildContext context) {
    return Spinner(
      spinning: loading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('About'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const Text('  App', style: TextStyle(color: Colors.black54)),
              ListTile(
                title: Text(appName ?? 'null'),
                subtitle: Text('version: $version'),
                leading: const Icon(
                  Icons.adb,
                  size: 40,
                ),
              ),
              const Divider(),
              const Text('  Setting', style: TextStyle(color: Colors.black54)),
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
              const Divider(),
              const Text('  Support Us',
                  style: TextStyle(color: Colors.black54)),
              ListTile(
                title: const Text('Donate'),
                subtitle: const Text('for maintanance and ❤️'),
                leading: const Icon(
                  Icons.volunteer_activism_rounded,
                  size: 40,
                ),
                trailing: const Icon(Icons.more_vert),
                onTap: () {
                  donate(context);
                },
              ),
              // const Text('OR', style: TextStyle(color: Colors.black54)),
              ListTile(
                title: const Text('Watch an Ad'),
                subtitle: const Text('feel free to watch Ads.'),
                leading: const Icon(
                  Icons.ads_click,
                  size: 40,
                ),
                trailing: const Icon(Icons.more_vert),
                onTap: () {
                  setState(() => loading = true);
                  loadAndShowAd();
                },
              ),
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

  Future<dynamic> donate(BuildContext context) async {
    await SharedPreferences.getInstance().then((pref) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          titlePadding: const EdgeInsets.only(top: 15, bottom: 3),
          contentPadding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          actionsAlignment: MainAxisAlignment.center,
          title: const Text('Donate', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text(
                  'Binance ID:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.copy),
                subtitle: const Text('776869887'),
                onTap: () async {
                  await Clipboard.setData(
                    const ClipboardData(text: '776869887'),
                  ).then(
                    (value) {
                      showSnackBar(context, 'Binance ID copied');
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Ethereum:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.copy),
                subtitle: const Text('0x7a74E821f...a82e33738'),
                onTap: () async {
                  await Clipboard.setData(
                    const ClipboardData(
                        text: '0x7a74E821fd1033176613dBf504919a2a82e33738'),
                  ).then(
                    (value) {
                      showSnackBar(context, 'Ethereum Address copied');
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Future loadAndShowAd() async {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {},
            onAdImpression: (ad) {},
            onAdFailedToShowFullScreenContent: ((ad, err) => ad.dispose()),
            onAdDismissedFullScreenContent: ((ad) => ad.dispose()),
            onAdClicked: (ad) {},
          );
          ad.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
            showThankYouPopup();
          });
          setState(() => loading = false);
        },
        onAdFailedToLoad: (LoadAdError error) {
          showSnackBar(context, 'Unable to show Ad, thanks for your move.');
          setState(() => loading = false);
        },
      ),
    );
  }

  void showThankYouPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Future.delayed(const Duration(seconds: 3), () {
        //   Navigator.of(context).pop();
        // });
        return AlertDialog(
          titlePadding: const EdgeInsets.all(20),
          title: Image.asset(
            'assets/thankyou/${getR()}.gif',
            width: 190,
            height: 190,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      },
    );
  }

  int getR() {
    Random random = Random();
    return random.nextInt(7) + 1;
  }
}
