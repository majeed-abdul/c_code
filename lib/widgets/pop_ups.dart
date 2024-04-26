import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:store_redirect/store_redirect.dart';

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      duration: const Duration(milliseconds: 2999),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

void joinBetaPopUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.only(top: 15, bottom: 9),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        actionsPadding: const EdgeInsets.only(right: 12, bottom: 11),
        title: const Text(
          'How to Join Beta?',
          textAlign: TextAlign.center,
        ),
        content: Image.asset(
          'assets/joinbeta.png',
          // width: 500,
          // height: 250,
        ),
        actions: [
          OutlinedButton(
              style: const ButtonStyle(
                visualDensity: VisualDensity(vertical: -0.3),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              StoreRedirect.redirect(androidAppId: "com.abdul.qr_maze");
            },
            child: const Text('Visit'),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      );
    },
  );
}

updatePopUp() async {
  // print('<<<<<<=============<<<<<<< initiated');
  await InAppUpdate.checkForUpdate().then(
    (value) async {
      if (value.updateAvailability == UpdateAvailability.updateAvailable) {
        await InAppUpdate.startFlexibleUpdate();
      }
    },
  );
  // print('<<<<<<<============inf=<<<<<<<<${info.availableVersionCode}');
}
