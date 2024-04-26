import 'package:qr_maze/functions/ads.dart';
import 'package:qr_maze/widgets/support_widgets.dart';
import 'package:qr_maze/widgets/loader.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:qr_maze/widgets/buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:qr_maze/widgets/pop_ups.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:safe_url_check/safe_url_check.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.result});
  final Barcode result;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

enum Display { raw, formated }

enum Verification { verifying, verified, notverified, noconnection }

class _ResultScreenState extends State<ResultScreen> {
  ScrollController scrollCon = ScrollController();
  String? formated;
  bool support = false;
  Display textFormat = Display.raw;
  String result = '';
  Verification veri = Verification.verifying;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500)).then(
      (value) => scrollCon.animateTo(
        scrollCon.position.maxScrollExtent,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 1400),
      ),
    );
    result = '${widget.result.code}';

    if (isWiFi()) {
      String name = result.substring(
        result.toUpperCase().indexOf('S:') + 2,
        result.indexOf(';', result.toUpperCase().indexOf('S:') + 1),
      );
      String pass = result.substring(
        result.toUpperCase().indexOf('P:') + 2,
        result.indexOf(';', result.toUpperCase().indexOf('P:') + 1),
      );
      String encr = result.substring(
        result.toUpperCase().indexOf('T:') + 2,
        result.indexOf(';', result.toUpperCase().indexOf('T:') + 1),
      );
      String hidd = result.substring(
        result.toUpperCase().contains('H:')
            ? result.toUpperCase().indexOf('H:') + 2
            : result.indexOf(';'),
        result.indexOf(';', result.toUpperCase().indexOf('H:') + 1),
      );
      formated = '''Name : $name
Password : ${encr.toUpperCase() == "NOPASS" ? '' : pass}
Encryption : ${encr.toUpperCase() == "NOPASS" ? 'None' : encr}
Hidden : $hidd''';
      textFormat = Display.formated;
    } //'*' * pass.length
    else if (isEmail()) {
      String email = result.toUpperCase().startsWith('MAILTO:')
          ? result.substring(
              result.toUpperCase().indexOf('TO:') + 3, // mailto:
              result.contains('?') ? result.indexOf('?') : null,
            )
          : result.substring(result.toUpperCase().indexOf(':TO:') + 4,
              result.toUpperCase().indexOf(';SUB:'));
      String subje = result.toUpperCase().startsWith('MAILTO:')
          ? result.substring(
              result.toUpperCase().contains('SUBJECT=')
                  ? result.toUpperCase().indexOf('SUBJECT=') + 8
                  : result.length, // mailto:
              result.toUpperCase().contains('&BODY=')
                  ? result.toUpperCase().indexOf('&BODY=')
                  : null,
            )
          : result.substring(
              result.toUpperCase().indexOf(';SUB:') + 5,
              result.indexOf(';BODY:'),
            );
      String messa = result.toUpperCase().startsWith('MAILTO:')
          ? result.substring(
              result.toUpperCase().contains('BODY=')
                  ? result.toUpperCase().indexOf('BODY=') + 5
                  : result.length, // mailto:
            )
          : result.substring(
              result.toUpperCase().indexOf(';BODY:') + 6,
              result.lastIndexOf(';') - 1,
            );
      formated = 'To : $email\nSubject : $subje\nMessage : $messa';
    } else if (isSMS()) {
      String num = result.substring(6, result.substring(7).indexOf(':') + 7);
      String msg = result.substring(result.substring(7).indexOf(':') + 8);
      formated = 'To : $num\nMessage : $msg';
      textFormat = Display.formated;
    } else if (isVCard()) {
      Contact vc = Contact.fromVCard(result);
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
      textFormat = Display.formated;
    } else if (isGeo()) {
      String lat;
      String lon;
      if (result.toUpperCase().contains('MAPS.GOOGLE.COM/LOCAL?Q=')) {
        String ss = result.toUpperCase();
        lat = ss.substring(ss.indexOf('?Q=') + 3, ss.indexOf(',')).trim();
        lon = ss.substring(ss.lastIndexOf(',') + 1).trim();
      } else {
        lat = result.substring(result.indexOf(':') + 1, result.indexOf(','));
        lon = result.substring(result.indexOf(',') + 1);
      }
      formated = 'Latitude: $lat\nLongitude: $lon';
      textFormat = Display.formated;
    } else if (isPhone()) {
      String phn = result.substring(result.toUpperCase().indexOf('TEL:') + 4);
      formated = 'Phone: $phn';
      textFormat = Display.formated;
    }

    /// let code below
    context.read<AdLoader>().loaderOff();
    if (isWebURL()) {
      InternetConnectionChecker().hasConnection.then((value) {
        if (value) {
          safeUrlCheck(
            Uri.parse(result),
            timeout: const Duration(seconds: 20),
          ).then((value) {
            switch (value) {
              case true:
                veri = Verification.verified;
                break;
              case false:
                veri = Verification.notverified;
                break;
              default:
                veri = Verification.noconnection;
            }
            setState(() {});
          });
        } else {
          setState(() {});
          veri = Verification.noconnection;
        }
      });
// if(result == true) {
//   print('YAY! Free cute dog pics!');
// } else {
//   print('No internet :( Reason:');
//   print(InternetConnectionChecker().lastTryResults);
// }
    }
    updatePopUp();
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
                        isWebURL()
                            ? 'URL'
                            : isNum()
                                ? 'Number'
                                : isVCard()
                                    ? 'Contact'
                                    : isGeo()
                                        ? 'Geo Location'
                                        : isEmail()
                                            ? 'Email'
                                            : isSMS()
                                                ? 'Message'
                                                : isWiFi()
                                                    ? 'WiFi'
                                                    : isPhone()
                                                        ? 'Phone'
                                                        : 'Text',
                        style: const TextStyle(
                          fontSize: 19,
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
          const Text('Connect', textAlign: TextAlign.center),
        ],
      );
      text = false;
    } else if (isVCard()) {
      w = Column(
        children: [
          customButton(onPress: () => _contact(), icon: Icons.call),
          const Text('Call', textAlign: TextAlign.center),
        ],
      );
      text = false;
    } else if (isEmail()) {
      w = Column(
        children: [
          customButton(
            onPress: () => _mail(),
            icon: Icons.email,
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
            icon: Icons.send,
          ),
          const Text('Send', textAlign: TextAlign.center),
        ],
      );
      text = false;
    } else if (isWebURL()) {
      w = Column(
        children: [
          customButton(onPress: () => _browse(), icon: Icons.language),
          const Text('Browse', textAlign: TextAlign.center),
        ],
      );
      text = false;
    } else if (isPhone()) {
      w = Column(
        children: [
          customButton(
            icon: Icons.call,
            onPress: () => _phone(),
          ),
          const Text('Call', textAlign: TextAlign.center),
        ],
      );
      text = false;
    } else if (isGeo()) {
      w = Column(
        children: [
          customButton(
            icon: Icons.my_location,
            onPress: () => _locate(),
          ),
          const Text('Locate', textAlign: TextAlign.center),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Visibility(
            visible: (isWebURL() || formated != null),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0, right: 5),
              child: Row(
                children: [
                  const Spacer(flex: 4),
                  Visibility(
                    visible: isWebURL(),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: veri == Verification.verifying
                          ? Image.asset(
                              'assets/loader.gif',
                              height: 20,
                              width: 20,
                            )
                          : veri == Verification.verified
                              ? const Icon(
                                  Icons.verified_user,
                                  color: Colors.green,
                                  size: 18,
                                )
                              : veri == Verification.notverified
                                  ? const Icon(
                                      Icons.report,
                                      color: Colors.red,
                                      size: 19,
                                    )
                                  : const Icon(
                                      Icons.wifi_off,
                                      color: Colors.black87,
                                      size: 19,
                                    ),
                    ),
                  ),
                  Visibility(
                    visible: isWebURL(),
                    child: Text(
                      veri == Verification.verifying
                          ? 'Verifying...'
                          : veri == Verification.verified
                              ? 'Safe'
                              : veri == Verification.notverified
                                  ? 'Something is Wrong'
                                  : 'No Connection',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: formated != null,
                    child: SegmentedButton<Display>(
                      segments: const <ButtonSegment<Display>>[
                        ButtonSegment(
                          value: Display.formated,
                          label: Text('Clean', style: TextStyle(fontSize: 12)),
                        ),
                        ButtonSegment(
                          value: Display.raw,
                          label: Text('Raw', style: TextStyle(fontSize: 12)),
                        ),
                      ],
                      selected: <Display>{textFormat},
                      showSelectedIcon: false,
                      onSelectionChanged: (Set<Display> newSelection) {
                        setState(() {
                          textFormat = newSelection.first;
                        });
                      },
                      style: const ButtonStyle(
                        visualDensity: VisualDensity(
                          horizontal: -3,
                          vertical: -3,
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        // RoundedRectangleBorder(
                        //     // side: const BorderSide(width: 3, color: Colors.amber),
                        //     // borderRadius: BorderRadius.circular(30),
                        //     ),
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SelectableText(
            textFormat == Display.raw ? result : formated ?? '',
            style: const TextStyle(fontSize: 15),
          ),
        ],
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

  void _locate() async {
    String lat;
    String lon;
    String ss = widget.result.code!.toUpperCase();
    if (result.toUpperCase().contains('MAPS.GOOGLE.COM/LOCAL?Q=')) {
      lat = ss.substring(ss.indexOf('?Q=') + 3, ss.indexOf(',')).trim();
      lon = ss.substring(ss.lastIndexOf(',') + 1).trim();
    } else {
      lat = result.substring(result.indexOf(':') + 1, result.indexOf(','));
      lon = result.substring(result.indexOf(',') + 1);
    }
    Uri url = Uri.parse('https://maps.google.com/local?q=$lat,$lon');
    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _phone() async {
    String pho = result.substring(result.toUpperCase().indexOf('TEL:') + 4);
    launchUrl(
      Uri(
        scheme: 'tel',
        path: pho,
      ),
    );
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

  bool isWebURL() {
    if (isGeo()) {
      return false;
    }
    try {
      return isURL(widget.result.code ?? '');
      // return Uri.tryParse(widget.result.code ?? '')?.isAbsolute ?? false;
    } catch (e) {
      return false;
    }
  }

  bool isWiFi() {
    bool validURL = widget.result.code!.toUpperCase().startsWith('WIFI:') &&
        widget.result.code!.endsWith(';');
    return validURL;
  }

  bool isGeo() {
    String res = widget.result.code!.toUpperCase();
    bool validGeo =
        res.startsWith('GEO:') || res.contains('MAPS.GOOGLE.COM/LOCAL?Q=');
    return validGeo;
  }

  bool isPhone() {
    bool validPhone = widget.result.code!.toUpperCase().startsWith('TEL:');
    return validPhone;
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
    bool validURL = widget.result.code!.toUpperCase().startsWith(
              "MATMSG:TO:",
            ) ||
        widget.result.code!.toUpperCase().startsWith(
              "MAILTO:",
            );
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
