import 'package:barcode_widget/barcode_widget.dart';
import 'package:c_code/functions/ads.dart';
import 'package:c_code/widgets/buttons.dart';
import 'package:c_code/widgets/loader.dart';
import 'package:c_code/widgets/pop_ups.dart';
import 'package:flutter/material.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:image/image.dart' as img;
import 'package:image/image.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';

class CodeDisplayScreen extends StatefulWidget {
  const CodeDisplayScreen({
    super.key,
    required this.data,
    required this.barCode,
  });
  final Barcode barCode;
  final String data;

  @override
  State<CodeDisplayScreen> createState() => _CodeDisplayScreenState();
}

class _CodeDisplayScreenState extends State<CodeDisplayScreen> {
  bool saved = false;

  @override
  Widget build(BuildContext context) {
    return Spinner(
      spinning: context.watch<AdLoader>().loader,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0, // toolbarHeight: 56,
          centerTitle: true,
          title: Text(widget.barCode.name),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              displayOutputCode(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      customButton(
                        onPress: () => support(context),
                        icon: Icons.volunteer_activism_rounded,
                      ),
                      const Text('Support', textAlign: TextAlign.center),
                    ],
                  ),
                  Column(
                    children: [
                      customButton(
                        onPress: () => saveit(),
                        icon: Icons.photo_library,
                      ),
                      const Text('Save', textAlign: TextAlign.center),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Text(widget.data),
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

  Widget displayOutputCode(BuildContext context) {
    return BarcodeWidget(
      height: MediaQuery.of(context).size.width <=
              MediaQuery.of(context).size.height
          ? MediaQuery.of(context).size.width - (60 * 2) //  portrait
          : MediaQuery.of(context).size.height - (60 * 2) - 56, //  landescape
      data: widget.data,
      barcode: widget.barCode,
      margin: const EdgeInsets.symmetric(vertical: 40),
      errorBuilder: (context, error) => _onError(error),
    );
  }

  Widget _onError(String message) {
    return Text(
      message.substring(message.indexOf('Barcode, '), message.length - 1),
    );
  }

  void saveit() {
    if (saved) {
      showSnackBar(context, 'Image Already Saved.');
      return;
    }
    final image = img.Image(width: 512, height: 512);
    fill(image, color: ColorRgb8(255, 255, 255));
    drawBarcode(
      image,
      widget.barCode,
      widget.data,
      height: 427, //  427 insted of 428 for 42px even padding across 4 sides
      width: 427,
      x: 42,
      y: 42,
    );
    final png = img.encodePng(image);
    ImageGallerySaver.saveImage(png);
    showSnackBar(context, 'Image Saved to Pictures. ✔️');
    saved = true;
  }

  void support(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 14),
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
                  Navigator.pop(context);
                  loadAndShowAd(context);
                },
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}
