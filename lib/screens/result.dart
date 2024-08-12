import 'package:qr_maze/functions/ads.dart';
import 'package:qr_maze/functions/result_idenity.dart';
import 'package:qr_maze/widgets/result_text.dart';
import 'package:qr_maze/widgets/support_widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:qr_maze/widgets/buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:qr_maze/widgets/pop_ups.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:flutter/services.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.result, this.history});
  final Barcode result;
  final String? history;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  ScrollController scrollCon = ScrollController();
  String? formated;
  bool support = false;
  String result = '';

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500)).then(
      (value) => scrollCon.animateTo(
        scrollCon.position.maxScrollExtent,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 1400),
      ),
    );
    if (widget.history == null) {
      result = widget.result.code ?? 'null';
    } else {
      result = widget.history ?? 'null';
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
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Result'),
            ),
            floatingActionButton: widget.history != null
                ? null
                : FloatingActionButton(
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
                    ResultText(res: result, history: widget.history != null),
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
                      onTap: (() {
                        showInterstitialAd(context);
                        setState(() => support = false);
                      }),
                    ),
                  ),
                  supportBottomSheet(context)
                ],
              ),
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

  Row buttonsRow() {
    Widget w = const SizedBox.shrink();
    bool text = true;
    if (widget.history == null) {
      result = widget.result.code ?? 'null';
    } else {
      result = widget.history ?? 'null';
    }
    if (isWiFi(result)) {
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
    } else if (isVCard(result)) {
      w = Column(
        children: [
          customButton(onPress: () => _contact(), icon: Icons.call),
          const Text('Call', textAlign: TextAlign.center),
        ],
      );
      text = false;
    } else if (isEmail(result)) {
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
    } else if (isSMS(result)) {
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
    } else if (isWebURL(result)) {
      w = Column(
        children: [
          customButton(onPress: () => _browse(), icon: Icons.language),
          const Text('Browse', textAlign: TextAlign.center),
        ],
      );
      text = false;
    } else if (isPhone(result)) {
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
    } else if (isGeo(result)) {
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

  // Container resultText() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(15),
  //       border: Border.all(color: Colors.black, width: 1),
  //     ),
  //     width: double.infinity,
  //     padding: const EdgeInsets.all(9),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         Visibility(
  //           // visible: (isWebURL() || formated != null),
  //           child: Padding(
  //             padding: const EdgeInsets.only(bottom: 0, right: 5),
  //             child: Row(
  //               children: [
  //                 const Spacer(flex: 4),
  //                 Visibility(
  //                   // visible: isWebURL(),
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(right: 2),
  //                     // child: veri == Verification.verifying
  //                     // ? Image.asset(
  //                     //     'assets/loader.gif',
  //                     //     height: 20,
  //                     //     width: 20,
  //                     //   )
  //                     // : veri == Verification.verified
  //                     //     ? const Icon(
  //                     //         Icons.verified_user,
  //                     //         color: Colors.green,
  //                     //         size: 18,
  //                     //       )
  //                     //     : veri == Verification.notverified
  //                     //         ? const Icon(
  //                     //             Icons.report,
  //                     //             color: Colors.red,
  //                     //             size: 19,
  //                     //           )
  //                     //         : const Icon(
  //                     //             Icons.wifi_off,
  //                     //             color: Colors.black87,
  //                     //             size: 19,
  //                     //           ),
  //                   ),
  //                 ),
  //                 // Visibility(
  //                 //   visible: isWebURL(),
  //                 //   child: Text(
  //                 //     veri == Verification.verifying
  //                 //         ? 'Verifying...'
  //                 //         : veri == Verification.verified
  //                 //             ? 'Safe'
  //                 //             : veri == Verification.notverified
  //                 //                 ? 'Something is Wrong'
  //                 //                 : 'No Connection',
  //                 //     style: const TextStyle(
  //                 //       fontSize: 13,
  //                 //       fontWeight: FontWeight.w500,
  //                 //     ),
  //                 //   ),
  //                 // ),
  //                 Visibility(
  //                   // visible: formated != null,
  //                   child: SegmentedButton<Display>(
  //                     segments: const <ButtonSegment<Display>>[
  //                       ButtonSegment(
  //                         value: Display.formated,
  //                         label: Text('Clean', style: TextStyle(fontSize: 12)),
  //                       ),
  //                       ButtonSegment(
  //                         value: Display.raw,
  //                         label: Text('Raw', style: TextStyle(fontSize: 12)),
  //                       ),
  //                     ],
  //                     selected: <Display>{textFormat},
  //                     showSelectedIcon: false,
  //                     onSelectionChanged: (Set<Display> newSelection) {
  //                       setState(() {
  //                         // textFormat = newSelection.first;
  //                       });
  //                     },
  //                     style: const ButtonStyle(
  //                       visualDensity: VisualDensity(
  //                         horizontal: -3,
  //                         vertical: -3,
  //                       ),
  //                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //                       // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                       // RoundedRectangleBorder(
  //                       //     // side: const BorderSide(width: 3, color: Colors.amber),
  //                       //     // borderRadius: BorderRadius.circular(30),
  //                       //     ),
  //                       // ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         SelectableText(
  //           'this is text',
  //           // textFormat == Display.raw ? result : formated ?? '',
  //           style: const TextStyle(fontSize: 15),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _copy() async {
    await Clipboard.setData(
      ClipboardData(text: result),
    ).then(
      (value) => showSnackBar(context, 'Copied'),
    );
  }

  void _browse() async {
    Uri url = Uri.parse(result);
    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _contact() async {
    // Contact contact = Contact.fromVCard(result);
    // await contact.insert();
    String word = result;
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
    double lat;
    double lon;
    String ss = result.toUpperCase();
    if (result.toUpperCase().contains('MAPS.GOOGLE.COM/LOCAL?Q=')) {
      lat = double.parse(
        ss.substring(ss.indexOf('?Q=') + 3, ss.indexOf(',')).trim(),
      );
      lon = double.parse(
        ss.substring(ss.lastIndexOf(',') + 1).trim(),
      );
    } else {
      lat = double.parse(
        result.substring(
          result.indexOf(':') + 1,
          result.indexOf(','),
        ),
      );
      lon = double.parse(
        result.substring(
          result.indexOf(',') + 1,
        ),
      );
    }
    try {
      await MapsLauncher.launchCoordinates(lat, lon);
    } catch (e) {
      // print('======eeeee:$e');
      Uri url = Uri.parse('https://maps.google.com/local?q=$lat,$lon');
      launchUrl(url, mode: LaunchMode.externalApplication); // OLD
    }
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
    String word = result;

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
    String word = result;

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
    String word = result;
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
}

String? _encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
