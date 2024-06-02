import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:qr_maze/functions/ads.dart';
import 'package:qr_maze/functions/result_idenity.dart';
import 'package:safe_url_check/safe_url_check.dart';

class ResultText extends StatefulWidget {
  const ResultText({super.key, required this.res});
  final String res;

  @override
  State<ResultText> createState() => _ResultTextState();
}

enum Display { raw, formated }

enum Verification { verifying, verified, notverified, noconnection }

class _ResultTextState extends State<ResultText> {
  Display textFormat = Display.raw;
  Verification veri = Verification.verifying;
  late String result;
  String? formated;
  @override
  void initState() {
    result = widget.res;

    if (isWiFi(widget.res)) {
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
      String hidd = result
          .substring(
            result.toUpperCase().contains('H:')
                ? result.toUpperCase().indexOf('H:') + 2
                : result.indexOf(';'),
            result.indexOf(';', result.toUpperCase().indexOf('H:') + 1),
          )
          .toUpperCase()
          .trim();
      formated = '''Name : $name
Password : ${encr.toUpperCase() == "NOPASS" ? '' : pass}
Encryption : ${encr.toUpperCase() == "NOPASS" ? 'None' : encr}
Hidden : ${hidd == 'TRUE' ? 'Yes' : 'No'}''';
      textFormat = Display.formated;
    } //'*' * pass.length
    else if (isEmail(widget.res)) {
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
      textFormat = Display.formated;
    } else if (isSMS(widget.res)) {
      String num = result.substring(6, result.substring(7).indexOf(':') + 7);
      String msg = result.substring(result.substring(7).indexOf(':') + 8);
      formated = 'To : $num\nMessage : $msg';
      textFormat = Display.formated;
    } else if (isVCard(widget.res)) {
      Contact vc = Contact.fromVCard(result);
      String name = vc.displayName;
      String addresses = '';
      for (Address i in vc.addresses) {
        addresses = '$addresses\n    ${i.label.name} address :  ${i.address}';
      }
      String emails = '';
      for (Email i in vc.emails) {
        emails = '$emails\n    ${i.label.name} email :  ${i.address}';
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
    } else if (isGeo(widget.res)) {
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
    } else if (isPhone(widget.res)) {
      String phn = result.substring(result.toUpperCase().indexOf('TEL:') + 4);
      formated = 'Phone: $phn';
      textFormat = Display.formated;
    }

    /// let code below
    // context.read<AdLoader>().loaderOff();
    if (isWebURL(widget.res)) {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isWebURL(widget.res)
              ? 'URL'
              : isNum(widget.res)
                  ? 'Number'
                  : isVCard(widget.res)
                      ? 'Contact'
                      : isGeo(widget.res)
                          ? 'Geo Location'
                          : isEmail(widget.res)
                              ? 'Email'
                              : isSMS(widget.res)
                                  ? 'Message'
                                  : isWiFi(widget.res)
                                      ? 'WiFi'
                                      : isPhone(widget.res)
                                          ? 'Phone'
                                          : 'Text',
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Container(
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
                visible: (isWebURL(widget.res) || formated != null),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0, right: 5),
                  child: Row(
                    children: [
                      const Spacer(flex: 4),
                      Visibility(
                        visible: isWebURL(widget.res),
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
                        visible: isWebURL(widget.res),
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
                              label:
                                  Text('Clean', style: TextStyle(fontSize: 12)),
                            ),
                            ButtonSegment(
                              value: Display.raw,
                              label:
                                  Text('Raw', style: TextStyle(fontSize: 12)),
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
        ),
      ],
    );
  }
}
