import 'package:barcode_widget/barcode_widget.dart';
import 'package:c_code/screens/code_display.dart';
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
                onChanged: (value) => finalWords = value,
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
              ),
            ),
            Visibility(
              visible: encryption != 'None',
              child: entryBar(
                text: 'Password',
                child: TextField(
                  decoration: kDecoration.copyWith(hintText: 'Enter Password'),
                  controller: wiFiPasCon,
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
                  onTap: () => setState(() => hidden = !hidden),
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
              ),
            ),
            entryBar(
              text: 'Last Name',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Last Name',
                ),
                controller: vCardLNaCon,
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
              ),
            ),
            entryBar(
              text: 'Company',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Company Name',
                ),
                controller: vCardComCon,
              ),
            ),
            entryBar(
              text: 'Job',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Job Title',
                ),
                controller: vCardJobCon,
              ),
            ),
            entryBar(
              text: 'Country',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Country Name',
                ),
                controller: vCardConCon,
              ),
            ),
            entryBar(
              text: 'State',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter State/Province Name',
                ),
                controller: vCardStaCon,
              ),
            ),
            entryBar(
              text: 'City',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter City Name',
                ),
                controller: vCardCitCon,
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
              ),
            ),
            entryBar(
              text: 'Subject',
              child: TextField(
                decoration: kDecoration.copyWith(
                  hintText: 'Enter Subject',
                ),
                controller: emailSubCon,
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
              onTap: () => setState(() => encryption = 'None'),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(
                      encryption == 'None'
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: encryption == 'None'
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
              onTap: () => setState(() => encryption = 'WPA'),
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
              onTap: () => setState(() => encryption = 'WEP'),
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
        if (finalWords!.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CodeDisplayScreen(
                data: finalWords,
                barCode: selectedCodeType,
                // barCode: numberBarcodes[dropDownValueType],=================
              ),
            ),
          );
        }
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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 7,
        childAspectRatio: 3,
        mainAxisSpacing: 7,
        mainAxisExtent: 45,
        crossAxisCount: 2,
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
            // context.read<CreateProvider>().createSelected == creates[index].name
            //     ? context.read<CreateProvider>().setCreate(creates[0].name)
            //     : context.read<CreateProvider>().setCreate(creates[index].name);
          },
        );
      },
    );
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
}
