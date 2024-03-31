import 'package:qr_maze/functions/ads.dart';
import 'package:flutter/material.dart';
import 'package:qr_maze/widgets/support_list.dart';

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
        const SizedBox(height: 15),
      ],
    ),
  );
}
