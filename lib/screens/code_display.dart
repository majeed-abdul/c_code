import 'package:barcode_widget/barcode_widget.dart';
import 'package:c_code/widgets/buttons.dart';
import 'package:c_code/widgets/pop_ups.dart';
import 'package:flutter/material.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:image/image.dart' as img;
import 'package:image/image.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

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
    return Scaffold(
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
            // Text(widget.data),
          ],
        ),
        // ),
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () {},
        //     child: const Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Icon(Icons.volunteer_activism_rounded),
        //         Text(
        //           'help',
        //           style: TextStyle(fontSize: 12),
        //         )
        //       ],
        //     )
        // // label: const Icon(Icons.volunteer_activism_rounded)),  //  for extended
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
}
