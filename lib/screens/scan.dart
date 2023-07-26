import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:c_code/widgets/buttons.dart';
import 'package:c_code/screens/result.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});
  static String id = 'scan_screen';

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
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        Container(child: _buildQrView(context)),
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
    );
  }

//

//

//                  E X T R A S

//

//

  Container cameraSwitchButton() {
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

  Container flashButton() {
    return customButton(
        onPress: () async {
          controller?.toggleFlash();
          isFlashOn = await controller?.getFlashStatus() ?? false;
          setState(() {});
        },
        icon: isFlashOn
            ? Icons.flashlight_on_outlined
            : Icons.flashlight_off_outlined,
        color: Colors.white);
  }

  Widget _buildQrView(BuildContext context) {
    double scanArea =
        MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.width / 1.25
            : MediaQuery.of(context).size.height / 1.5;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.greenAccent,
        borderRadius: 1,
        borderLength: 40,
        borderWidth: 9,
        cutOutSize: scanArea,
      ),
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
    ).then((value) => controller?.resumeCamera());
  }
}
