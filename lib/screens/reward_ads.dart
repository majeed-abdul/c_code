// import 'package:flutter/material.dart';

// class RewardedExampleState extends State<RewardedExample> {
//   RewardedAd? _rewardedAd;

//   // TODO: replace this test ad unit with your own ad unit.
//   final adUnitId = Platform.isAndroid
//     ? 'ca-app-pub-3940256099942544/5224354917'
//     : 'ca-app-pub-3940256099942544/1712485313';

//   /// Loads a rewarded ad.
//   void loadAd() {
//     RewardedAd.load(
//         adUnitId: adUnitId,
//         request: const AdRequest(),
//         adLoadCallback: RewardedAdLoadCallback(
//           // Called when an ad is successfully received.
//           onAdLoaded: (ad) {
//             debugPrint('$ad loaded.');
//             // Keep a reference to the ad so you can show it later.
//             _rewardedAd = ad;
//           },
//           // Called when an ad request failed.
//           onAdFailedToLoad: (LoadAdError error) {
//             debugPrint('RewardedAd failed to load: $error');
//           },
//         ));
//   }
// }