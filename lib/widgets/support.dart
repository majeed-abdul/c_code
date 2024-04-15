import 'package:flutter/material.dart';
import 'package:qr_maze/functions/ads.dart';
import 'package:qr_maze/widgets/pop_ups.dart';
import 'package:share_plus/share_plus.dart';

String shareMessage = '''
Unlock the Next Level in QR Scanning
with QR Sensor.

Why Choose Our App?

 • Experience Extra layer of security.
 • Navigate with Ease and Speed.
 • Say Goodbye to Intrusive Ads(Watch on Your Terms).
 • Check out App for More.

Don't miss out on upgrading from conventional QR scanners.

Download now!
https://play.google.com/store/apps/details?id=com.abdul.qr_maze''';

share(BuildContext context, ShareResult result) {
  if (result.status == ShareResultStatus.success) {
    showSnackBar(context, 'Thank you for sharing my App ❤️');
  }
}

ListTile shareApp(BuildContext context) {
  return ListTile(
    iconColor: Colors.black54,
    title: const Text('Share'),
    subtitle: const Text('Share app with friends & family.'),
    leading: const Icon(Icons.share, size: 38),
    trailing: const Icon(Icons.more_vert),
    onTap: () async {
      await Share.shareWithResult(shareMessage).then(
        (value) => share(context, value),
      );
    },
  );
}

ListTile donatePop(BuildContext context) {
  return ListTile(
    iconColor: Colors.black54,
    title: const Text('Donate ❤️'),
    subtitle: const Text('We need support to keep you up to date.'),
    leading: const Icon(Icons.volunteer_activism_rounded, size: 40),
    trailing: const Icon(
      Icons.more_vert,
    ),
    onTap: () => donate(context),
  );
}

ListTile seeAds(BuildContext context) {
  return ListTile(
    iconColor: Colors.black54,
    title: const Text('Support (See ads)'),
    subtitle: const Text('Support us by watching Ads.'),
    leading: const Icon(Icons.ads_click, size: 40),
    trailing: const Icon(Icons.more_vert),
    onTap: () {
      loadAndShowAd(context);
    },
  );
}
