import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_maze/data/hive/model.dart';
import 'package:qr_maze/screens/result.dart';
import 'package:qr_maze/widgets/pop_ups.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

// enum SampleItem { Copy, Delete }

class _HistoryState extends State<History> {
  final Box<ScannedData> scannedBox = Hive.box<ScannedData>('scannedCodes');
  // SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan History'),
        actions: [
          IconButton(
            onPressed: () async {
              await showDeleteAlert(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: scannedBox.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No scan data found'));
          }
          return ListView(
            children: [
              ListView.separated(
                shrinkWrap: true,
                reverse: true,
                itemCount: box.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final scannedData = (box.getAt(index) as ScannedData);
                  return ListTile(
                    minVerticalPadding: 5,
                    minTileHeight: 59,
                    // dense: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ResultScreen(
                            result: Barcode(' ', BarcodeFormat.qrcode, []),
                            history: scannedData.data,
                          ),
                        ),
                      );
                    },
                    title: Text(
                      scannedData.type,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      scannedData.title.trim(),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                    ),
                    leading: Icon(iconSelector(scannedData.type), size: 31),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(DateFormat('h:mm a')
                                .format(scannedData.dateTime)),
                            Text(
                              DateFormat('d/MMM/yyy')
                                  .format(scannedData.dateTime),
                            )
                          ],
                        ),
                        MenuAnchor(
                          builder: (
                            BuildContext context,
                            MenuController controller,
                            Widget? child,
                          ) {
                            return IconButton(
                              onPressed: () {
                                if (controller.isOpen) {
                                  controller.close();
                                } else {
                                  controller.open();
                                }
                              },
                              icon: const Icon(Icons.more_vert),
                              tooltip: 'Menu',
                            );
                          },
                          menuChildren: [
                            // MenuItemButton(
                            //   onPressed: () async {
                            //     // await Clipboard.setData(
                            //     //   ClipboardData(text: scannedData.password),
                            //     // ).then(
                            //     //   (value) {
                            //     //     showSnackBar(context, 'Password Copied');
                            //     //   },
                            //     // );
                            //   },
                            //   child: const Text('Copy Password'),
                            // ),
                            MenuItemButton(
                              onPressed: () async {
                                scannedBox.deleteAt(index);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),

                        // IconButton(
                        //   onPressed: () {},
                        //   icon: const Icon(Icons.more_vert),
                        // )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ],
          );
        },
      ),
      // bottomNavigationBar: BannerAds(),
    );
  }

  IconData iconSelector(String type) {
    switch (type) {
      case 'URL':
        return Icons.link;
      case 'Number':
        return Icons.numbers;
      case 'WiFi':
        return Icons.wifi_rounded;
      case 'Contact':
        return Icons.person_outline;
      case 'Email':
        return Icons.email_outlined;
      case 'Message':
        return Icons.sms_outlined;
      case 'Geo Location':
        return Icons.location_on_outlined;
      case 'Phone':
        return Icons.phone_outlined;
      default:
        return Icons.text_fields_rounded;
    }
  }
}
