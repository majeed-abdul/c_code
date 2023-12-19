import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:c_code/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:image/image.dart' as img;
import 'package:image/image.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0, // toolbarHeight: 56,
        centerTitle: true,
        title: Text(widget.barCode.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            displayOutputCode(context),
            Column(
              children: [
                customButton(
                  onPress: () => saveit(),
                  icon: Icons.photo_library,
                ),
                const Text('Save', textAlign: TextAlign.center),
              ],
            ),
            const SizedBox(height: 15),
            Text(widget.data),
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

  void saveit() async {
    await Permission.manageExternalStorage.request();
    // Create an image
    final image = img.Image(width: 300, height: 300);
    // Fill it with a solid color (white)
    fill(image, color: ColorRgb8(255, 255, 255));
    // Draw the barcode
    drawBarcode(image, Barcode.qrCode(), 'Test', font: arial24);
    // Save the image
    // Directory root = await getTemporaryDirectory();
    // String directoryPath = '${root.path}';
    // await Directory(directoryPath).create(recursive: false);
    // File(directoryPath).writeAsBytes(encodePng(image));
    //
    // final byteData = image.;
    // Encode the resulting image to the PNG image format.
    final png = img.encodePng(image);
    // Write the PNG formatted data to a file.
    await File('image.png').writeAsBytes(png).then(
          (value) => print('QR Code image saved to Pictures'),
        );
  }
}
