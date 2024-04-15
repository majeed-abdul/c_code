import 'package:flutter/material.dart';
import 'package:qr_maze/widgets/support.dart';

Container supportBottomSheet(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 20,
            bottom: 14,
          ),
          child: Text(
            'Support Us',
            style: TextStyle(fontSize: 16),
            selectionColor: Colors.black54,
          ),
        ),
        const Divider(),
        shareApp(context),
        donatePop(context),
        seeAds(context),
        const Divider(),
        const SizedBox(height: 15),
      ],
    ),
  );
}
