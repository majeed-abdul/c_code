// ignore_for_file: use_build_context_synchronously

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:qr_maze/data/hive/functions.dart';
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

Future<void> showDeleteAlert(
  BuildContext context,
) async {
  return showDialog<void>(
    context: context,
    // barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Delete All',
          // textAlign: TextAlign.center,
        ),
        content: const Text(
          'Are you sure you want to delete all the scanned wifi passwords history.',
          // textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          OutlinedButton(
            child: const Text('Delete all'),
            onPressed: () async {
              await clearAllQRCodeHistory().then((v) {
                Navigator.of(context).pop();
              });
            },
          ),
          FilledButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void wifiQR(
  BuildContext context,
  String name,
  String data,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        // titlePadding: const EdgeInsets.only(top: 15, bottom: 9),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        title: Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black),
        ),
        content: _displayOutputCode(context, data),
        actions: const [
          Text(
            'Scan to connect',
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}

Widget _displayOutputCode(BuildContext context, String data) {
  Widget w;
  try {
    w = BarcodeWidget(
      // height: MediaQuery.of(context).size.width <=
      //         MediaQuery.of(context).size.height
      //     ? MediaQuery.of(context).size.width - 80 // (40*2)  portrait
      //     : MediaQuery.of(context).size.height - 160, // (40*2)+24+56
      data: data,
      barcode: Barcode.qrCode(),
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      errorBuilder: (context, error) => _onError(error),
    );
  } catch (e) {
    w = _onError(e.toString());
  }
  return SizedBox(height: 240, width: 240, child: w);
}

Widget _onError(String message) {
  return Text(
    message.substring(message.indexOf('Barcode, '), message.length - 1),
  );
}
