import 'package:qr_maze/functions/ads.dart';
import 'package:qr_maze/widgets/loader.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_maze/widgets/buttons.dart';
import 'package:qr_maze/widgets/pop_ups.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:provider/provider.dart';
// import 'package:wifi_iot/wifi_iot.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.result});
  final Barcode result;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  ScrollController scrollCon = ScrollController();
  String? formated;
  bool support = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500)).then(
      (value) => scrollCon.animateTo(
        scrollCon.position.maxScrollExtent,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 1500),
      ),
    );
    String word = '${widget.result.code}';
    if (isWiFi()) {
      String name = word.substring(
        word.toUpperCase().indexOf('S:') + 2,
        word.indexOf(';', word.toUpperCase().indexOf('S:') + 1),
      );
      String pass = word.substring(
        word.toUpperCase().indexOf('P:') + 2,
        word.indexOf(';', word.toUpperCase().indexOf('P:') + 1),
      );
      String encr = word.substring(
        word.toUpperCase().indexOf('T:') + 2,
        word.indexOf(';', word.toUpperCase().indexOf('T:') + 1),
      );
      String hidd = word.substring(
        word.toUpperCase().contains('H:')
            ? word.toUpperCase().indexOf('H:') + 2
            : word.indexOf(';'),
        word.indexOf(';', word.toUpperCase().indexOf('H:') + 1),
      );
      formated = '''Name : $name
Password : ${encr.toUpperCase() == "NOPASS" ? '' : pass}
Encryption : ${encr.toUpperCase() == "NOPASS" ? 'None' : encr}
Hidden : $hidd''';
    } //'*' * pass.length
    else if (isEmail()) {
      String email = word.toUpperCase().startsWith('MAILTO:')
          ? word.substring(
              word.toUpperCase().indexOf('TO:') + 3, // mailto:
              word.contains('?') ? word.indexOf('?') : null,
            )
          : word.substring(word.toUpperCase().indexOf(':TO:') + 4,
              word.toUpperCase().indexOf(';SUB:'));
      String subje = word.toUpperCase().startsWith('MAILTO:')
          ? word.substring(
              word.toUpperCase().contains('SUBJECT=')
                  ? word.toUpperCase().indexOf('SUBJECT=') + 8
                  : word.length, // mailto:
              word.toUpperCase().contains('&BODY=')
                  ? word.toUpperCase().indexOf('&BODY=')
                  : null,
            )
          : word.substring(
              word.toUpperCase().indexOf(';SUB:') + 5,
              word.indexOf(';BODY:'),
            );
      String messa = word.toUpperCase().startsWith('MAILTO:')
          ? word.substring(
              word.toUpperCase().contains('BODY=')
                  ? word.toUpperCase().indexOf('BODY=') + 5
                  : word.length, // mailto:
            )
          : word.substring(
              word.toUpperCase().indexOf(';BODY:') + 6,
              word.lastIndexOf(';') - 1,
            );
      formated = 'Email : $email\nSubject : $subje\nMessage : $messa';
    } else if (isSMS()) {
      String num = word.substring(6, word.substring(7).indexOf(':') + 7);
      String msg = word.substring(word.substring(7).indexOf(':') + 8);
      formated = 'Number : $num\nMessage : $msg';
    } else if (isVCard()) {
      Contact vc = Contact.fromVCard(word);
      String name = vc.displayName;
      String addresses = '';
      for (Address i in vc.addresses) {
        addresses = '$addresses\n    ${i.label.name} address :  ${i.address}';
      }
      String emails = '';
      for (Email i in vc.emails) {
        emails = '$emails    ${i.label.name} email :  ${i.address}';
      }
      String orgs = '';
      for (Organization i in vc.organizations) {
        orgs = '$orgs\n    ${i.company}, Job: ${i.title}';
      }
      String phones = '';
      for (Phone i in vc.phones) {
        phones = '$phones\n    ${i.label.name} number: ${i.number}';
      }
      String websites = '';
      for (Website i in vc.websites) {
        websites = '$websites\n    ${i.customLabel} number: ${i.url}';
      }
      formated = '''Name: $name
Address: $addresses
Email: $emails
Organizations: $orgs
Contact: $phones
Websites : $websites''';
    }
    context.read<AdLoader>().loaderOff();
    setState(() {});
    super.initState();
  }

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
                centerTitle: true,
                title: const Text('Result'),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.pop(context),
                child: const Icon(Icons.qr_code_scanner_outlined, size: 30),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: scrollCon,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        isWiFi()
                            ? 'WiFi'
                            : isNum()
                                ? 'Number'
                                : isVCard()
                                    ? 'V-Card'
                                    : isEmail()
                                        ? 'Email'
                                        : isSMS()
                                            ? 'SMS'
                                            : isURL()
                                                ? 'URL'
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

  Row buttonsRow() {
    Widget w = const SizedBox.shrink();
    bool text = true;
    if (isWiFi()) {
      w = Column(
        children: [
          customButton(
            onPress: () => _wifiConect(),
            icon: Icons.wifi_rounded,
          ),
          const Text('Conect', textAlign: TextAlign.center),
        ],
      );
      text = false;
    } else if (isNum()) {
    } else if (isVCard()) {
      w = Column(
        children: [
          customButton(onPress: () => _contact(), icon: Icons.call),
          const Text('V-Card', textAlign: TextAlign.center),
        ],
      );
      text = false;
    } else if (isEmail()) {
      w = Column(
        children: [
          customButton(
            onPress: () => _mail(),
            icon: Icons.email_outlined,
          ),
          const Text('Email', textAlign: TextAlign.center),
        ],
      );
      text = false;
    } else if (isSMS()) {
      w = Column(
        children: [
          customButton(
            onPress: () => _sms(),
            icon: Icons.sms_outlined,
          ),
          const Text('SMS', textAlign: TextAlign.center),
        ],
      );
      text = false;
    } else if (isURL()) {
      w = Column(
        children: [
          customButton(onPress: () => _browse(), icon: Icons.link),
          const Text('Browse', textAlign: TextAlign.center),
        ],
      );
      text = false;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            customButton(
              onPress: () => setState(() => support = true),
              icon: Icons.volunteer_activism_rounded,
            ),
            const Text('Support', textAlign: TextAlign.center),
          ],
        ),
        Column(
          children: [
            customButton(onPress: () => _copy(), icon: Icons.copy),
            const Text('Copy', textAlign: TextAlign.center),
          ],
        ),
        w,
      ].sublist(0, (text) ? 2 : 3),
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
        formated ?? widget.result.code ?? '',
        // widget.result.code ?? '',
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

  void _contact() async {
    // Contact contact = Contact.fromVCard('${widget.result.code}');
    // await contact.insert();
    String word = '${widget.result.code}';
    Contact vc = Contact.fromVCard(word);
    String num = vc.phones[0].number;
    if (num.isEmpty) {
      showSnackBar(context, 'No number exists');
    } else {
      launchUrl(
        Uri(
          scheme: 'tel',
          path: num,
        ),
      );
    }
  }

  void _mail() async {
    String word = '${widget.result.code}';

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: word.toUpperCase().startsWith('MAILTO:')
          ? word.substring(
              word.toUpperCase().indexOf('TO:') + 3, // mailto:
              word.contains('?') ? word.indexOf('?') : null,
            )
          : word.substring(
              word.toUpperCase().indexOf(':TO:') + 4,
              word.indexOf(';SUB:'),
            ),
      query: _encodeQueryParameters(
        <String, String>{
          'subject': word.toUpperCase().startsWith('MAILTO:')
              ? word.substring(
                  word.toUpperCase().contains('SUBJECT=')
                      ? word.toUpperCase().indexOf('SUBJECT=') + 8
                      : word.length, // mailto:
                  word.toUpperCase().contains('&BODY=')
                      ? word.toUpperCase().indexOf('&BODY=')
                      : null,
                )
              : word.substring(
                  word.toUpperCase().indexOf(';SUB:') + 5,
                  word.indexOf(';BODY:'),
                ),
          'body': word.toUpperCase().startsWith('MAILTO:')
              ? word.substring(
                  word.toUpperCase().contains('BODY=')
                      ? word.toUpperCase().indexOf('BODY=') + 5
                      : word.length, // mailto:
                )
              : word.substring(
                  word.toUpperCase().indexOf(';BODY:') + 6,
                  word.lastIndexOf(';') - 1,
                ),
        },
      ),
    );
    launchUrl(emailLaunchUri);
  }

  void _sms() async {
    String word = '${widget.result.code}';

    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: word.substring(6, word.substring(7).indexOf(':') + 7),
      query: _encodeQueryParameters(
        <String, String>{
          'body': word.substring(word.substring(7).indexOf(':') + 8),
        },
      ),
    );
    launchUrl(smsLaunchUri);
  }

  void _wifiConect() async {
    String word = '${widget.result.code}';
    String ssid = word.substring(
      word.toUpperCase().indexOf('S:') + 2,
      word.indexOf(';', word.toUpperCase().indexOf('S:') + 1),
    );
    String password = word.substring(
      word.toUpperCase().indexOf('P:') + 2,
      word.indexOf(';', word.toUpperCase().indexOf('P:') + 1),
    );
    String security = word.substring(
      word.toUpperCase().indexOf('T:') + 2,
      word.indexOf(';', word.toUpperCase().indexOf('T:') + 1),
    );
    String hidden = word.substring(
      word.toUpperCase().contains('H:')
          ? word.toUpperCase().indexOf('H:') + 2
          : word.indexOf(';'),
      word.indexOf(';', word.toUpperCase().indexOf('H:') + 1),
    );
    try {
      // await WifiConnector.connectToWifi(
      //   ssid: ssid,
      //   password: password,
      //   isWEP: security.toUpperCase() == 'WEP',      TEST
      // );

      await WiFiForIoTPlugin.registerWifiNetwork(
        ssid,
        password: password,
        security: security.toUpperCase() == "WPA"
            ? NetworkSecurity.WPA
            : security.toUpperCase() == "WEP"
                ? NetworkSecurity.WEP
                : NetworkSecurity.NONE,
        isHidden: hidden.toUpperCase() == 'TRUE',
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'Try ti connect Manually\n ($e)');
    }
  }

  bool isURL() {
    try {
      return Uri.tryParse(widget.result.code ?? '')?.isAbsolute ?? false;
    } catch (e) {
      return false;
    }
  }

  bool isWiFi() {
    bool validURL = widget.result.code!.toUpperCase().startsWith('WIFI:') &&
        widget.result.code!.endsWith(';');
    return validURL;
  }

  bool isVCard() {
    bool validURL =
        "${widget.result.code}".toUpperCase().startsWith('BEGIN:VCARD') &&
            "${widget.result.code}"
                .trim()
                .toUpperCase()
                .endsWith('END:VCARD'); //need testing
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

String? _encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
