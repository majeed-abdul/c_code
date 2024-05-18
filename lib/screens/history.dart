import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:qr_maze/data/hive/model.dart';
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
        title: const Text('Wifi History'),
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
            return const Center(child: Text('No Wifi data found'));
          }
          return ListView(
            children: [
              ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: box.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final scannedData = (box.getAt(index) as ScannedData);
                  return ListTile(
                    title: Text(scannedData.type),
                    subtitle: Text(scannedData.title),
                    leading: const Icon(Icons.wifi_rounded, size: 38),
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
                              tooltip: 'Show menu',
                            );
                          },
                          menuChildren: [
                            MenuItemButton(
                              onPressed: () async {
                                // await Clipboard.setData(
                                //   ClipboardData(text: scannedData.password),
                                // ).then(
                                //   (value) {
                                //     showSnackBar(context, 'Password Copied');
                                //   },
                                // );
                              },
                              child: const Text('Copy Password'),
                            ),
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
                // separatorBuilder: (context, index) => const Divider(),
              ),
            ],
          );
        },
      ),
      // bottomNavigationBar: BannerAds(),
    );
  }
}
