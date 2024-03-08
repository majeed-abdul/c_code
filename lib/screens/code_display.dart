import 'package:barcode_widget/barcode_widget.dart';
import 'package:qr_maze/functions/ads.dart';
import 'package:qr_maze/widgets/bottom_sheet.dart';
import 'package:qr_maze/widgets/buttons.dart';
import 'package:qr_maze/widgets/loader.dart';
import 'package:qr_maze/widgets/pop_ups.dart';
import 'package:flutter/material.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';
import 'package:image/image.dart';

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
  bool error = false;
  bool saved = false;
  bool support = false;

  @override
  void initState() {
    context.read<AdLoader>().loaderOff();
    super.initState();
  }
  // @override
  // void didChangeDependencies() {
  //   print('=====didChange');
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (support) {
          setState(() => support = false);
          return false;
        } else {
          return true;
        }
      },
      child: Spinner(
        spinning: context.watch<AdLoader>().loader,
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                // toolbarHeight: 56,
                centerTitle: true,
                title: Text(widget.barCode.name),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      displayOutputCode(context),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                customButton(
                                  onPress: () => setState(() => support = true),
                                  icon: Icons.volunteer_activism_rounded,
                                ),
                                const Text('Support',
                                    textAlign: TextAlign.center),
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
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: support,
              child: Scaffold(
                backgroundColor: Colors.black54,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (() => setState(() => support = false)),
                      ),
                    ),
                    supportBottomSheet(context)
                  ],
                ),
              ),
            ),
          ],
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
    Widget w;
    try {
      w = BarcodeWidget(
        height: MediaQuery.of(context).size.width <=
                MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.width - 80 // (40*2)  portrait
            : MediaQuery.of(context).size.height - 160, // (40*2)+24+56
        data: widget.data,
        barcode: widget.barCode,
        margin: const EdgeInsets.all(40),
        errorBuilder: (context, error) => _onError(error),
      );
    } catch (e) {
      w = _onError(e.toString());
    }
    return w;
  }

  Widget _onError(String message) {
    error = true;
    return Text(
      message.substring(message.indexOf('Barcode, '), message.length - 1),
    );
  }

  void saveit() {
    if (saved) {
      showSnackBar(context, 'Image Already Saved.');
      return;
    }
    if (error) {
      showSnackBar(context, 'No code Generated.');
      return;
    }
    final image = img.Image(width: 1024, height: 1024);
    fill(image, color: ColorRgb8(255, 255, 255));
    drawBarcode(
      image,
      widget.barCode,
      widget.data,
      height: 871, //  871 insted of 872 for 76 px even padding across 4 sides
      width: 871, //  1024-(76*2)-1
      x: 76,
      y: 76,
    );
    final png = img.encodePng(image);
    ImageGallerySaver.saveImage(png);
    showSnackBar(context, 'Image Saved to Pictures. ✔️');
    saved = true;
  }
}
