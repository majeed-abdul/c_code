import 'package:email_validator/email_validator.dart';
import 'package:qr_maze/screens/code_display.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:qr_maze/widgets/drop_down.dart';
import 'package:qr_maze/widgets/pop_ups.dart';
import 'package:qr_maze/widgets/text_field.dart';
import 'package:qr_maze/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:qr_maze/data/create.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  int selected = 0; // grid selector
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
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Create'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              // const Divider(height: 1),
              Container(
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: buttonsGrid(), /////////////////////// Grid Buttons
              ),
              const SizedBox(height: 9),
              // buttonsGrid(),
              // const SizedBox(height: 11),
              // const Divider(),
              entryTextFields(), /////////////////////////// Inputs Fields
              const SizedBox(height: 11),
              createButton(), //////////////////////////// Crerate Buttons
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
            const Text(
              'Text & URL',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            entryBar(
              text: 'Text / url',
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                minLines: 3,
                decoration: const InputDecoration(hintText: 'Enter Text'),
                onChanged: (value) => finalWords = value.trim(),
                controller: stringCon,
              ),
            ),
            moreOptions(),
          ],
        );
        break;
      case 4: ////////////// Numbers
        w = Column(
          children: [
            const Text(
              'Number',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            entryBar(
              text: 'Number',
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Enter Number'),
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
                    const Text('More options'),
                    const SizedBox(width: 10),
                    isMore
                        ? const Icon(Icons.check_circle, size: 22)
                        : const Icon(Icons.circle_outlined,
                            size: 22, color: Colors.black54),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isMore,
              child: dropDown(
                items: numberBarcodes.keys.toList(),
                onChanged: (v) {
                  dropDownValueTypeNum = v;
                  selectedCodeType = numberBarcodes[v] ?? Barcode.qrCode();
                  setState(() {});
                },
                dropDownValue: dropDownValueTypeNum,
                text: 'Type',
              ),
            ),
          ],
        );
        break;
      case 1: ////////////// WiFi
        w = Column(
          children: [
            const Text(
              'Wifi',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            entryBar(
              text: 'WiFi Name',
              child: TextField(
                decoration: const InputDecoration(hintText: 'Enter SSId'),
                controller: wiFiNamCon,
                onChanged: (value) => setWiFi(),
              ),
            ),
            Visibility(
              visible: encryption != 'nopass',
              child: entryBar(
                text: 'Password',
                child: TextField(
                  decoration: const InputDecoration(hintText: 'Enter Password'),
                  controller: wiFiPasCon,
                  onChanged: (value) => setWiFi(),
                ),
              ),
            ),
            encryptionRadioButtons(),
            entryBar(
              text: 'Hidden',
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  hidden = !hidden;
                  setWiFi();
                  setState(() {});
                },
                child: Row(
                  children: [
                    hidden
                        ? const Icon(Icons.check_circle, size: 22)
                        : const Icon(
                            Icons.circle_outlined,
                            color: Colors.black54,
                            size: 22,
                          ),
                  ],
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
            const Text(
              'V-Card',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            entryBar(
              text: 'First Name',
              child: TextField(
                decoration:
                    const InputDecoration(hintText: 'Enter First tName'),
                controller: vCardFNaCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Last Name',
              child: TextField(
                decoration: const InputDecoration(hintText: 'Enter Last Name'),
                controller: vCardLNaCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Mobile No',
              child: TextField(
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(hintText: 'Enter Fax Number'),
                keyboardType: TextInputType.phone,
                controller: vCardFaxCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Email',
              child: TextField(
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
                  hintText: 'Enter Company Name',
                ),
                controller: vCardComCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Job',
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter Job Title',
                ),
                controller: vCardJobCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Country',
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter Country Name',
                ),
                controller: vCardConCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'State',
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter State/Province Name',
                ),
                controller: vCardStaCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'City',
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter City Name',
                ),
                controller: vCardCitCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Zip',
              child: TextField(
                decoration:
                    const InputDecoration(hintText: 'Enter Postal Code'),
                keyboardType: TextInputType.number,
                controller: vCardZipCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            entryBar(
              text: 'Street',
              child: TextField(
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(hintText: 'Enter Web URL'),
                keyboardType: TextInputType.emailAddress,
                controller: vCardWebCon,
                onChanged: (v) => setVCard(),
              ),
            ),
            moreOptions(),
          ],
        );
        break;
      case 2: //////////// Geo-Location
        w = Column(
          children: [
            const Text(
              'Geo-Location',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            entryBar(
              text: 'Latitude',
              child: TextField(
                decoration: const InputDecoration(hintText: 'Enter Latitude'),
                controller: emailTooCon,
                // onChanged: (v) => setMail(),
              ),
            ),
            entryBar(
              text: 'Longitude',
              child: TextField(
                decoration: const InputDecoration(hintText: 'Enter Longitude'),
                controller: emailSubCon,
                // onChanged: (v) => setMail(),
              ),
            ),
            moreOptions(),
          ],
        );
        break;
      case 5: ////////////// Email
        w = Column(
          children: [
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 19,
                // height: 1.7,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            entryBar(
              text: 'To',
              child: TextField(
                decoration: const InputDecoration(hintText: 'Enter Email'),
                controller: emailTooCon,
                onChanged: (v) => setMail(),
              ),
            ),
            entryBar(
              text: 'Subject',
              child: TextField(
                decoration: const InputDecoration(hintText: 'Enter Subject'),
                controller: emailSubCon,
                onChanged: (v) => setMail(),
              ),
            ),
            entryBar(
              text: 'Message',
              child: TextField(
                decoration: const InputDecoration(hintText: 'Enter Message'),
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
      case 6: ////////////// SMS
        w = Column(
          children: [
            const Text(
              'SMS',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            entryBar(
              text: 'Phone No',
              child: TextField(
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(hintText: 'Enter Message'),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: w,
    );
  }

  Widget encryptionRadioButtons() {
    bool isNon = encryption == 'nopass';
    bool isWPA = encryption == 'WPA';
    bool isWEP = encryption == 'WEP';
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
                    isNon
                        ? const Icon(Icons.check_circle, size: 22)
                        : const Icon(Icons.circle_outlined,
                            color: Colors.black54, size: 22),
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
                    isWPA
                        ? const Icon(Icons.check_circle, size: 22)
                        : const Icon(Icons.circle_outlined,
                            color: Colors.black54, size: 22),
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
                    isWEP
                        ? const Icon(Icons.check_circle, size: 22)
                        : const Icon(Icons.circle_outlined,
                            color: Colors.black54, size: 22),
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
                const Text('More options'),
                const SizedBox(width: 10),
                isMore
                    ? const Icon(Icons.check_circle, size: 22)
                    : const Icon(Icons.circle_outlined,
                        color: Colors.black54, size: 22),
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

  FilledButton createButton() {
    return FilledButton(
      onPressed: () {
        try {
          switch (selected) {
            case 0: ////////////// Text & URL
              if (stringCon.text.trim().isEmpty) {
                throw 'Enter Text'; //  must not be empty
              }
              break;
            case 4: ////////////// Number
              if (numberCon.text.isEmpty) {
                throw 'Enter Number'; //  must not be empty
              } else {
                isNumber(numberCon.text) ? null : throw 'Invalid Number';
              }
              if (selectedCodeType == Barcode.ean5()) {
                numberCon.text.length == 5
                    ? null
                    : throw 'Number is not 5 digit';
              }
              if (selectedCodeType == Barcode.ean2()) {
                numberCon.text.length == 2
                    ? null
                    : throw 'Number is not 2 digit';
              }
              if (selectedCodeType == Barcode.ean8()) {
                numberCon.text.length == 8
                    ? null
                    : throw 'Number is not 8 digit';
              }
              break;
            case 1: ////////////// WIFi
              if (wiFiNamCon.text.trim().isEmpty) {
                throw 'Enter SSID'; //  must not be empty
              } else if (wiFiPasCon.text.isEmpty && encryption != 'nopass') {
                throw 'Enter Password'; //  must not be empty
              }
              break;
            case 3: ////////////// V-Card
              if (vCardFNaCon.text.trim().isEmpty &&
                  vCardLNaCon.text.trim().isEmpty) {
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
              isEmail(vCardEmaCon.text) ? null : throw 'Invalid Email';
              break;
            // vCardComCon
            // vCardJobCon
            // vCardConCon
            // vCardStaCon
            // vCardCitCon
            // vCardStrCon
            // vCardWebCon
            case 5: ////////////// Email
              if (emailTooCon.text.trim().isEmpty) {
                throw "Enter Email"; //  must not be empty
              } else if (emailSubCon.text.trim().isEmpty) {
                throw 'Enter Subject'; //  must not be empty
              } else if (emailMsgCon.text.trim().isEmpty) {
                throw 'Enter Message'; //  must not be empty
              }
              isEmail(emailTooCon.text) ? null : throw 'Invalid Email';
              break;
            case 6: ////////////// SMS
              if (smsPhoCon.text.trim().isEmpty) {
                throw "Enter Phone Number"; //  must not be empty
              } else if (smsPhoCon.text.trim().length < 3) {
                throw 'Enter more than 2 digits in Phone Number'; //  must not be empty
              } else if (smsMsgCon.text.trim().isEmpty) {
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
        padding: EdgeInsets.all(12),
        child: Text('Create', style: TextStyle(fontSize: 15)),
      ),
    );
  }

  SizedBox buttonsGrid() {
    // Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 70,
      child: ListView.separated(
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisSpacing: 7,
        //   childAspectRatio: 3,
        //   mainAxisSpacing: 7,
        //   mainAxisExtent: 45,
        //   crossAxisCount:
        //       (size.width >= size.height) || (size.width > 900) ? 3 : 2,
        // ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        itemCount: creates.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10);
        },
        itemBuilder: (context, index) {
          return gridButton(
            select: index == selected,
            icon: creates[index].icon,
            label: creates[index].name,
            onTap: () {
              clearControllers();
              dropDownValueType = 'QR Code';
              selected = index;
              setState(() {});
            },
          );
        },
      ),
    );
  }

  bool isEmail(String email) {
    if (email.isEmpty) return true;
    return EmailValidator.validate(email);
  }

  clearControllers() {
    FocusScope.of(context).unfocus(); //  For Keyboard Dismis
    selectedCodeType = Barcode.qrCode(); //defasult value
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
    finalWords = '''BEGIN:VCARD
VERSION:3.0
N:${vCardLNaCon.text.trim()};${vCardFNaCon.text.trim()}
FN:${vCardFNaCon.text.trim()} ${vCardLNaCon.text.trim()}
ORG:${vCardComCon.text.trim()}
TITLE:${vCardJobCon.text.trim()}
ADR:;;${vCardStrCon.text.trim()};${vCardCitCon.text.trim()};${vCardStaCon.text.trim()};${vCardZipCon.text.trim()};${vCardConCon.text.trim()}
TEL;WORK;VOICE:${vCardPhoCon.text.trim()}
TEL;CELL:${vCardMobCon.text.trim()}
TEL;FAX:${vCardFaxCon.text.trim()}
EMAIL;WORK;INTERNET:${vCardEmaCon.text.trim()}
URL:${vCardWebCon.text.trim()}
END:VCARD''';
  }

  setMail() {
    finalWords =
        "MAILTO:${emailTooCon.text.trim()}?BODY=${emailMsgCon.text.trim()}&SUBJECT=${emailSubCon.text.trim()}";
  }

  setSMS() {
    finalWords = "SMSTO:${smsPhoCon.text.trim()}:${smsMsgCon.text.trim()}";
  }
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
