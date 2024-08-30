import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_maze/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:qr_maze/screens/result.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'dart:io';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});
  // static String id = 'scan_screen';

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isFlashOn = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPotrait =
        MediaQuery.of(context).size.width < MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          Container(child: _buildQrView()),
          // ScreenShot Comment
          // Image.asset(
          //   'assets/screenshot.png',
          //   height: double.infinity,
          //   fit: BoxFit.cover,
          // ),
          QRScannerOverlay(
            overlayColor: Colors.black26,
            scanAreaSize: Size.square(
              isPotrait
                  ? MediaQuery.of(context).size.width - 90
                  : MediaQuery.of(context).size.height - 125,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(55),
            child: MediaQuery.of(context).size.width <
                    MediaQuery.of(context).size.height
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      cameraSwitchButton(),
                      flashButton(),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      flashButton(),
                      cameraSwitchButton(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

//

//

//                  E X T R A S

//

//

  OutlinedButton cameraSwitchButton() {
    return customButton(
      onPress: () async {
        if (isFlashOn) {
          controller?.toggleFlash();
          isFlashOn = await controller?.getFlashStatus() ?? false;
          setState(() {});
        }
        controller?.flipCamera();
      },
      icon: Icons.flip_camera_ios_outlined,
      color: Colors.white,
    );
  }

  OutlinedButton flashButton() {
    return customButton(
      onPress: () async {
        controller?.toggleFlash();
        isFlashOn = await controller?.getFlashStatus() ?? false;
        setState(() {});
      },
      icon: isFlashOn
          ? Icons.flashlight_on_outlined
          : Icons.flashlight_off_outlined,
      color: Colors.white,
    );
  }

  Widget _buildQrView() {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      // overlay: QrScannerOverlayShape(
      //   borderColor: Theme.of(context).primaryColor,
      //   cutOutSize: scanArea,
      //   borderLength: 40,
      //   borderRadius: 1,
      //   borderWidth: 9,
      // ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      _onScanComplete(scanData);
    });
  }

  void _onScanComplete(Barcode code) async {
    controller?.pauseCamera();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ResultScreen(result: code),
      ),
    ).then(
      (value) => controller?.resumeCamera(),
    );
  }
}
