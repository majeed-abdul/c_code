import 'package:barcode_widget/barcode_widget.dart';
import 'package:c_code/screens/code_display.dart';
import 'package:c_code/widgets/pop_ups.dart';
import 'package:c_code/widgets/text_field.dart';
import 'package:c_code/widgets/drop_down.dart';
import 'package:c_code/widgets/buttons.dart';
import 'package:c_code/data/create.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  int selected = 0;
  //  All
  String? dropDownValueType = textBarcodes.keys.first;
  Barcode selectedCodeType = Barcode.qrCode();
  bool isMore = false;
  String? finalWords;

  //  String
  TextEditingController stringCon = TextEditingController();

  //  Number
  TextEditingController numberCon = TextEditingController();
  String? dropDownValueTypeNum = numberBarcodes.keys.first;

  //  WiFi
  TextEditingController wiFiNamCon = TextEditingController();
  TextEditingController wiFiPasCon = TextEditingController();
  String encryption = 'WPA';
  bool hidden = false;

  //  V-Card
  TextEditingController vCardFNaCon = TextEditingController();
  TextEditingController vCardLNaCon = TextEditingController();
  TextEditingController vCardMobCon = TextEditingController();
  TextEditingController vCardPhoCon = TextEditingController();
  TextEditingController vCardFaxCon = TextEditingController();
  TextEditingController vCardEmaCon = TextEditingController();
  TextEditingController vCardComCon = TextEditingController();
  TextEditingController vCardJobCon = TextEditingController();
  TextEditingController vCardConCon = TextEditingController();
  TextEditingController vCardStaCon = TextEditingController();
  TextEditingController vCardCitCon = TextEditingController();
  TextEditingController vCardZipCon = TextEditingController();
  TextEditingController vCardStrCon = TextEditingController();
  TextEditingController vCardWebCon = TextEditingController();

  //  Email
  TextEditingController emailTooCon = TextEditingController();
  TextEditingController emailSubCon = TextEditingController();
  TextEditingController emailMsgCon = TextEditingController();

  //  SMS
  TextEditingController smsPhoCon = TextEditingController();
  TextEditingController smsMsgCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Create'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              buttonsGrid(), /////////////////////////////// Grid Buttons
              const SizedBox(height: 20),
              entryTextFields(), /////////////////////////// Inputs Fields
              const SizedBox(height: 11),
              createButton(), ////////////////////////// Crerate Buttons
              const SizedBox(height: 20),
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

  Widget entryTextFields() {
    Widget w;
    switch (selected) {
      case 0: ////////////// Text & URL
        w = Column(
          children: [
            entryBar(
              text: 'Text / url',
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                minLines: 3,
                decoration: kDecoration.copyWith(hintText: 'Enter Text'),
                onChanged: (value) => finalWords = value.trim(),
                controller: stringCon,
              ),
            ),
            moreOptions(),
          ],
        );
        break;
      case 1: ////////////// Numbers
        w = Column(
          children: [
            entryBar(
              text: 'Number',
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: kDecoration.copyWith(hintText: 'Enter Number'),
                controller: numberCon,
                onChanged: (value) => finalWords = value.trim(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              child: GestureDetector(
                onTap: () => setState(() => isMore = !isMore),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'More options',
                    ),
                    const SizedBox(width: 10),
                    isMore
                        ? Icon(
                            Icons.check_box,
                            size: 21,
                            color: Theme.of(context).primaryColor,
                          )
                        : const Icon(
                            Icons.check_box_outline_blank_rounded,
                            size: 21,
                            color: Colors.black87,
                          ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isMore,
              child: dropDown(
                items: numberBarcodes.keys.toList(),
                onChanged: (value) {
                  dropDownValueTypeNum = value;
                  setState(() {});
                },
                dropDownValue: dropDownValueTypeNum,
                text: 'Type',
              ),
            ),
          ],
        );
        break;
      case 2: ////////////// WiFi
        w = Column(
          children: [
            entryBar(
              text: 'WiFi Name',
              child: TextField(
                decoration: kDecoration.copyWith(hintText: 'Enter SSID'),
                controller: wiFiNamCon,
                onChanged: (value) => setWiFi(),
              ),
            ),
            Visibility(
              visible: encryption != 'nopass',
              child: entryBar(
                text: 'Password',
                child: TextField(
                  decoration: kDecoration.copyWith(hintText: 'Enter Password'),
                  controller: wiFiPasCon,
                  onChanged: (value) => setWiFi(),
                ),
              ),
            ),
            encryptionRadioButtons(),
            entryBar(
              text: 'Hidden',
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () => setState(() {
                    hidden = !hidden;
                    setWiFi();
                  }),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(
                          hidden
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          size: 21,
                          color: hidden ? Theme.of(context).primaryColor : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            moreOptions(),
          ],
        );
        break;
      case 3: ////////////// V-Card
        w = Column(
          children: [
            entryBar(
              text: 'First Name',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter First tName',
                ),
                controller: vCardFNaCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Last Name',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Last Name',
                ),
                controller: vCardLNaCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Mobile No',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Mobile Number',
                ),
                keyboardType: TextInputType.phone,
                controller: vCardMobCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Phone No',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Phone Number',
                ),
                keyboardType: TextInputType.phone,
                controller: vCardPhoCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Fax',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Fax Number',
                ),
                keyboardType: TextInputType.phone,
                controller: vCardFaxCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Email',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Email Address',
                ),
                keyboardType: TextInputType.emailAddress,
                controller: vCardEmaCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Company',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Company Name',
                ),
                controller: vCardComCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Job',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Job Title',
                ),
                controller: vCardJobCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Country',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Country Name',
                ),
                controller: vCardConCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'State',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter State/Province Name',
                ),
                controller: vCardStaCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'City',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter City Name',
                ),
                controller: vCardCitCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Zip',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Postal Code',
                ),
                keyboardType: TextInputType.number,
                controller: vCardZipCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Street',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Street Address',
                ),
                keyboardType: TextInputType.streetAddress,
                controller: vCardStrCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Website',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Web URL',
                ),
                keyboardType: TextInputType.emailAddress,
                controller: vCardWebCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            moreOptions(),
          ],
        );
        break;
      case 4: ////////////// Email
        w = Column(
          children: [
            entryBar(
              text: 'To',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Email',
                ),
                controller: emailTooCon,
                onChanged: (v) => setMail(),
              ),
            ),
            entryBar(
              text: 'Subject',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Subject',
                ),
                controller: emailSubCon,
                onChanged: (v) => setMail(),
              ),
            ),
            entryBar(
              text: 'Message',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Message',
                ),
                maxLines: 6,
                minLines: 3,
                controller: emailMsgCon,
                onChanged: (v) => setMail(),
              ),
            ),
            moreOptions(),
          ],
        );
        break;
      case 5: ////////////// SMS
        w = Column(
          children: [
            entryBar(
              text: 'Phone No',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Phone Number',
                ),
                keyboardType: TextInputType.phone,
                controller: smsPhoCon,
                onChanged: (v) => setSMS(),
              ),
            ),
            entryBar(
              text: 'Message',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Message',
                ),
                maxLines: 6,
                minLines: 3,
                controller: smsMsgCon,
                onChanged: (v) => setSMS(),
              ),
            ),
            moreOptions(),
          ],
        );
        break;
      default:
        w = const SizedBox();
    }
    return w;
  }

  Widget encryptionRadioButtons() {
    return entryBar(
        text: 'Encryption',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                setState(() => encryption = 'nopass');
                setWiFi();
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(
                      encryption == 'nopass'
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: encryption == 'nopass'
                          ? Theme.of(context).primaryColor
                          : null,
                      size: 21,
                    ),
                    const Text(' None'),
                  ],
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                setState(() => encryption = 'WPA');
                setWiFi();
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(
                      encryption == 'WPA'
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: encryption == 'WPA'
                          ? Theme.of(context).primaryColor
                          : null,
                      size: 21,
                    ),
                    const Text(' WPA/WPA-2'),
                  ],
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                setState(() => encryption = 'WEP');
                setWiFi();
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(
                      encryption == 'WEP'
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: encryption == 'WEP'
                          ? Theme.of(context).primaryColor
                          : null,
                      size: 21,
                    ),
                    const Text(' WEP'),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Column moreOptions() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
          child: GestureDetector(
            onTap: () => setState(() => isMore = !isMore),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'More options',
                ),
                const SizedBox(width: 10),
                isMore
                    ? Icon(
                        Icons.check_box,
                        size: 21,
                        color: Theme.of(context).primaryColor,
                      )
                    : const Icon(
                        Icons.check_box_outline_blank_rounded,
                        size: 21,
                        color: Colors.black87,
                      )
              ],
            ),
          ),
        ),
        Visibility(
          visible: isMore,
          child: dropDown(
            items: textBarcodes.keys.toList(),
            onChanged: (value) {
              dropDownValueType = value;
              selectedCodeType = textBarcodes[value] ?? Barcode.qrCode();
              setState(() {});
            },
            dropDownValue: dropDownValueType,
            text: 'Type',
          ),
        ),
      ],
    );
  }

  ElevatedButton createButton() {
    return ElevatedButton(
      onPressed: () {
        try {
          switch (selected) {
            case 0: ////////////// Text & URL
              if (stringCon.text.isEmpty) {
                throw 'Enter Text'; //  must not be empty
              }
              break;
            case 1: ////////////// Number
              if (numberCon.text.isEmpty) {
                throw 'Enter Number'; //  must not be empty
              } else {
                isNumber(numberCon.text) ? null : throw 'Invalid Number';
              }
              break;
            case 2: ////////////// WIFi
              if (wiFiNamCon.text.isEmpty) {
                throw 'Enter SSID'; //  must not be empty
              } else if (wiFiPasCon.text.isEmpty && encryption != 'nopass') {
                throw 'Enter Password'; //  must not be empty
              }
              break;
            case 3: ////////////// V-Card
              if (vCardFNaCon.text.isEmpty && vCardLNaCon.text.isEmpty) {
                throw 'Enter Name'; //  must not be empty
              } else if (vCardMobCon.text.isEmpty &&
                  vCardPhoCon.text.isEmpty &&
                  vCardEmaCon.text.isEmpty) {
                throw 'Enter Any Contact Number or Email'; //  must not be empty
              }
              isNumber(vCardMobCon.text) ? null : throw 'Invalid Mobile Number';
              isNumber(vCardPhoCon.text) ? null : throw 'Invalid Phone Number';
              isNumber(vCardFaxCon.text) ? null : throw 'Invalid Fax Number';
              isNumber(vCardZipCon.text) ? null : throw 'Invalid Zip Code';
              break;
// vCardFNaCon
// vCardLNaCon
// vCardMobCon
// vCardPhoCon
// vCardFaxCon
// vCardEmaCon
// vCardComCon
// vCardJobCon
// vCardConCon
// vCardStaCon
// vCardCitCon
// vCardZipCon
// vCardStrCon
// vCardWebCon
            case 4: ////////////// Email
              if (emailTooCon.text.isEmpty) {
                throw "Enter Email"; //  must not be empty
              } else if (emailSubCon.text.isEmpty) {
                throw 'Enter Subject'; //  must not be empty
              } else if (emailMsgCon.text.isEmpty) {
                throw 'Enter Message'; //  must not be empty
              }
              isEmail(emailTooCon.text) ? null : throw 'Invalid Email';
              break;
            case 5: ////////////// SMS
              if (smsPhoCon.text.isEmpty) {
                throw "Enter Phone Number"; //  must not be empty
              } else if (smsMsgCon.text.isEmpty) {
                throw 'Enter Message'; //  must not be empty
              }
              isNumber(smsPhoCon.text) ? null : throw 'Invalid Phone Number';
              break;
          }
        } catch (e) {
          showSnackBar(context, e.toString());
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CodeDisplayScreen(
              data: '$finalWords',
              barCode: selectedCodeType,
            ),
          ),
        );
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'Create',
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  GridView buttonsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 7,
        childAspectRatio: 3,
        mainAxisSpacing: 7,
        mainAxisExtent: 45,
        crossAxisCount: MediaQuery.of(context).size.width >=
                MediaQuery.of(context).size.height
            ? 3
            : 2,
      ),
      itemCount: creates.length,
      itemBuilder: (context, index) {
        return gridButton(
          name: creates[index].name,
          icon: creates[index].icon,
          selected: index == selected,
          onTap: () {
            clearControllers();
            selected = index;
            setState(() {});
          },
        );
      },
    );
  }

  bool isNumber(String num) {
    try {
      double.parse(num);
    } on FormatException {
      if (num.isEmpty) return true;
      return false;
    }
    return true;
  }

  bool isEmail(String email) {
    if (email.isEmpty) return true;
    final emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(email);
  }

  clearControllers() {
    //  Default Values
    FocusScope.of(context).unfocus(); //  For SKeyboard Dismis
    dropDownValueType = textBarcodes.keys.first;
    finalWords = null;
    isMore = false;
    //  String
    stringCon.clear();
    //  Number
    numberCon.clear();
    //  WiFi
    wiFiNamCon.clear();
    wiFiPasCon.clear();
    //  V-Card
    vCardFNaCon.clear();
    vCardLNaCon.clear();
    vCardMobCon.clear();
    vCardPhoCon.clear();
    vCardFaxCon.clear();
    vCardEmaCon.clear();
    vCardComCon.clear();
    vCardJobCon.clear();
    vCardConCon.clear();
    vCardStaCon.clear();
    vCardCitCon.clear();
    vCardZipCon.clear();
    vCardStrCon.clear();
    vCardWebCon.clear();
    //  Email
    emailTooCon.clear();
    emailSubCon.clear();
    emailMsgCon.clear();
    //  SMS
    smsPhoCon.clear();
    smsMsgCon.clear();
  }

  setWiFi() {
    finalWords =
        "WIFI:T:$encryption;S:${wiFiNamCon.text.trim()};P:${encryption == 'nopass' ? 'null' : wiFiPasCon.text};H:${hidden ? 'true' : 'false'};;";
  }

  setVCard() {
    finalWords =
        "BEGIN:VCARD\nVERSION:3.0\nN:${vCardLNaCon.text.trim()};${vCardFNaCon.text.trim()}\nFN:${vCardFNaCon.text.trim()} ${vCardLNaCon.text.trim()}\nORG:${vCardComCon.text.trim()}\nTITLE:${vCardJobCon.text.trim()}\nADR:;;${vCardStrCon.text.trim()};${vCardCitCon.text.trim()};${vCardStaCon.text.trim()};${vCardZipCon.text.trim()};${vCardConCon.text.trim()}\nTEL;WORK;VOICE:${vCardPhoCon.text.trim()}\nTEL;CELL:${vCardMobCon.text.trim()}\nTEL;FAX:${vCardFaxCon.text.trim()}\nEMAIL;WORK;INTERNET:${vCardEmaCon.text.trim()}\nURL:${vCardWebCon.text.trim()}\nEND:VCARD";
  }

  setMail() {
    finalWords =
        "mailto:${emailTooCon.text.trim()}?body=${emailMsgCon.text.trim()}&subject=${emailSubCon.text.trim()}";
  }

  setSMS() {
    finalWords = "SMSTO:${smsPhoCon.text.trim()}:${smsMsgCon.text.trim()}";
  }
}
