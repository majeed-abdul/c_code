import 'package:c_code/widgets/pop_ups.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:math';

const adUnitId = 'ca-app-pub-9338573690135257/6850625011';
void donate(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      titlePadding: const EdgeInsets.only(top: 15, bottom: 3),
      contentPadding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
            onTap: () {
              Clipboard.setData(
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
            onTap: () {
              Clipboard.setData(
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
}

void showThankYouPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.all(20),
        title: Image.asset(
          'assets/thankyou/${getR7()}.gif',
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

int getR7() {
  Random random = Random();
  return random.nextInt(7) + 1;
}

void loadAndShowAd(BuildContext context) {
  RewardedAd.load(
    adUnitId: adUnitId,
    request: const AdRequest(),
    rewardedAdLoadCallback: RewardedAdLoadCallback(
      onAdLoaded: (ad) {
        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (ad) {},
          onAdImpression: (ad) {},
          onAdFailedToShowFullScreenContent: ((ad, err) => ad.dispose()),
          onAdDismissedFullScreenContent: ((ad) => ad.dispose()),
          onAdClicked: (ad) {},
        );
        ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
          showThankYouPopup(context);
        });
      },
      onAdFailedToLoad: (LoadAdError error) {
        showSnackBar(context, 'Unable to show Ad, thanks for your move.');
      },
    ),
  );
}

class Ads extends ChangeNotifier {
  bool? loader;
  loaderOn() {
    loader = true;
    notifyListeners();
  }

  loaderOff() {
    loader = false;
    notifyListeners();
  }
}
