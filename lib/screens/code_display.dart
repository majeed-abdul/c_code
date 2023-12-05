import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
        // toolbarHeight: 56,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.barCode.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [displayOutputCode(context), Text(widget.data ?? '')],
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
      data: widget.data ?? '',
      barcode: widget.barCode ?? Barcode.qrCode(),
      margin: const EdgeInsets.symmetric(vertical: 40),
      errorBuilder: (context, error) => _onError(error),
    );
  }

  Widget _onError(String message) {
    return Text(
      message.substring(message.indexOf('Barcode, '), message.length - 1),
    );
  }
}
