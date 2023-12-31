import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:c_code/widgets/buttons.dart';
import 'package:c_code/widgets/pop_ups.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.result});
  final Barcode result;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  ScrollController scrollCon = ScrollController();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500)).then(
      (value) => scrollCon.animateTo(
        scrollCon.position.maxScrollExtent,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 1500),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Result'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.qr_code_scanner_outlined, size: 30),
      ),
      body: SingleChildScrollView(
        controller: scrollCon,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                isURL()
                    ? 'URL'
                    : isWiFi()
                        ? 'WiFi'
                        : isNum()
                            ? 'Number'
                            : isVCard()
                                ? 'V-Card'
                                : isEmail()
                                    ? 'Email'
                                    : isSMS()
                                        ? 'SMS'
                                        : 'Text',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              resultText(),
              const SizedBox(height: 20),
              buttonsRow(),
              const SizedBox(height: 55),
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

  Row buttonsRow() {
    Widget w = const SizedBox.shrink();
    bool text = true;
    if (isURL()) {
      w = Column(
        children: [
          customButton(onPress: () => _browse(), icon: Icons.link),
          const Text('Browse', textAlign: TextAlign.center),
        ],
      );
      text = false;
    }
    if (isVCard()) {
      w = Column(
        children: [
          customButton(
              // onPress: () => _browse(),
              icon: Icons.contact_emergency_outlined),
          const Text('V-Card', textAlign: TextAlign.center),
        ],
      );
      text = false;
    }
    if (isEmail()) {
      w = Column(
        children: [
          customButton(onPress: () => _mail(), icon: Icons.email_outlined),
          const Text('Email', textAlign: TextAlign.center),
        ],
      );
      text = false;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            customButton(onPress: () => _copy(), icon: Icons.copy),
            const Text('Copy', textAlign: TextAlign.center),
          ],
        ),
        w,
      ].sublist(0, (text) ? 1 : 2),
    );
  }

  Container resultText() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 1),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(9),
      child: SelectableText(
        '${widget.result.code}',
        style: const TextStyle(fontSize: 15),
      ),
    );
  }

  void _copy() async {
    await Clipboard.setData(
      ClipboardData(text: '${widget.result.code}'),
    ).then(
      (value) => showSnackBar(context, 'Copied'),
    );
  }

  void _browse() async {
    Uri url = Uri.parse(widget.result.code ?? '');
    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _mail() async {
    String word = '${widget.result.code}';
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: word.substring(
        word.toUpperCase().indexOf('TO:') + 3,
        word.indexOf(';'),
      ),
      query: encodeQueryParameters(
        <String, String>{
          'subject': word.substring(
            word.toUpperCase().indexOf('TO:') + 3,
            word.indexOf(';'),
          ),
        },
      ),
    );
    launchUrl(emailLaunchUri);
  }

  bool isURL() {
    bool valid =
        Uri.tryParse(widget.result.code ?? 's')?.hasAbsolutePath ?? false;
    return valid;
  }

  bool isWiFi() {
    bool validURL =
        widget.result.code!.toUpperCase().startsWith('BEGIN:VCARD') &&
            widget.result.code!.toUpperCase().endsWith('END:VCARD');
    return validURL;
  }

  bool isVCard() {
    bool validURL =
        widget.result.code!.toUpperCase().startsWith('BEGIN:VCARD') &&
            widget.result.code!.toUpperCase().endsWith('END:VCARD');
    return validURL;
  }

  bool isEmail() {
    bool validURL =
        widget.result.code!.toUpperCase().startsWith("MATMSG:TO:") ||
            widget.result.code!.toUpperCase().startsWith("MAILTO:");
    return validURL;
  }

  bool isSMS() {
    bool validURL = widget.result.code!.toUpperCase().startsWith("SMSTO:");
    return validURL;
  }

  bool isNum() {
    try {
      double.parse('${widget.result.code}');
    } on FormatException {
      if (widget.result.code!.isEmpty) return true;
      return false;
    }
    return true;
  }
}
