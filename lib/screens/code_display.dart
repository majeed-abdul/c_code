import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class CodeDisplayScreen extends StatefulWidget {
  const CodeDisplayScreen({super.key, this.data, this.barCode});
  final String? data;
  final Barcode? barCode;

  @override
  State<CodeDisplayScreen> createState() => _CodeDisplayScreenState();
}

class _CodeDisplayScreenState extends State<CodeDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('AnyCode'),
      ),
      body: Column(children: [displayOutputCode(context)]),
    );
  }

//

//

//                  E X T R A S

//

//

  BarcodeWidget displayOutputCode(BuildContext context) {
    return BarcodeWidget(
      height: MediaQuery.of(context).size.width <=
              MediaQuery.of(context).size.height
          ? MediaQuery.of(context).size.width - 60 * 2
          : MediaQuery.of(context).size.height - 60 * 2,
      data: widget.data ?? '',
      barcode: widget.barCode ?? Barcode.qrCode(),
      padding: const EdgeInsets.all(20),
      errorBuilder: (context, error) => _onError(error),
    );
  }

  Widget _onError(String message) {
    return Text(
      message.substring(message.indexOf('Barcode, '), message.length - 1),
    );
  }
}
