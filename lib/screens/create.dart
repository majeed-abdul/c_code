import 'package:barcode_widget/barcode_widget.dart';
import 'package:c_code/screens/code_display.dart';
import 'package:c_code/widgets/text_field.dart';
import 'package:c_code/widgets/drop_down.dart';
import 'package:c_code/widgets/buttons.dart';
import 'package:c_code/data/provider.dart';
import 'package:c_code/data/create.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TextEditingController textCon = TextEditingController();
  String? dropDownValueTypeNum = numberBarcodes.keys.first;
  String? dropDownValueType = textBarcodes.keys.first;
  Barcode selectedCodeType = Barcode.qrCode();

  bool isMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Create'),
        // actions: [
        //   IconButton(
        //     onPressed: () => Navigator.pushNamed(context, ScanScreen.id),
        //     icon: const Icon(Icons.qr_code_scanner),
        //   ),
        // ],
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
              createButtonsRow(), ////////////////////////// Crerate Buttons
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
    // switch (creates.indexWhere((element) =>
    //     element.name == context.watch<CreateProvider>().createSelected)) {
    switch (creates.indexWhere((element) {
      return element.name == context.watch<CreateProvider>().createSelected;
    })) {
      case 0: ////////////// Text & URL
        w = Column(
          children: [
            entryBar(
              text: 'Text',
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 20,
                minLines: 1,
                controller: textCon,
                decoration: kDecoration.copyWith(hintText: 'Enter Text'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              child: GestureDetector(
                onTap: () {
                  isMore = !isMore;
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'More options',
                    ),
                    const SizedBox(width: 10),
                    isMore
                        ? const Icon(
                            Icons.check_box,
                            size: 20,
                            color: Color.fromRGBO(255, 80, 80, 1),
                          )
                        : const Icon(
                            Icons.check_box_outline_blank_rounded,
                            size: 20,
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
                  debugPrint("   $dropDownValueType");
                },
                dropDownValue: dropDownValueType,
                text: 'Type',
              ),
            ),
          ],
        );
        break;
      case 1: ////////////// Numbers
        w = Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              entryBar(
                text: 'Number',
                child: TextField(
                  controller: textCon,
                  keyboardType: TextInputType.number,
                  decoration: kDecoration.copyWith(hintText: 'Enter Number'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    isMore = !isMore;
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'More options',
                      ),
                      const SizedBox(width: 10),
                      isMore
                          ? const Icon(
                              Icons.check_box,
                              size: 20,
                              color: Color.fromRGBO(255, 80, 80, 1),
                            )
                          : const Icon(
                              Icons.check_box_outline_blank_rounded,
                              size: 20,
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
          ),
        );
        break;
      case 2: ////////////// V-Card
        w = TextField(
          controller: textCon,
          decoration: kDecoration.copyWith(hintText: 'Enter contact'),
        );
        break;
      case 3: ////////////// Email
        w = TextField(
          controller: textCon,
          decoration: kDecoration.copyWith(hintText: 'Enter EMail'),
        );
        break;
      case 4: ////////////// SMS
        w = TextField(
          controller: textCon,
          decoration: kDecoration.copyWith(hintText: 'Enter sms'),
        );
        break;
      case 5: ////////////// WiFi
        w = entryBar(
          child: TextField(
            controller: textCon,
            decoration: kDecoration.copyWith(hintText: 'Enter WIFW'),
          ),
        );
        break;
      default:
        w = const SizedBox();
    }
    return w;
  }

  ElevatedButton createButtonsRow() {
    return ElevatedButton(
      onPressed: () {
        if (textCon.text.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CodeDisplayScreen(
                data: textCon.text,
                barCode: selectedCodeType,
                // barCode: numberBarcodes[dropDownValueType],=================
              ),
            ),
          );
        }
      },
      child: const Text('Create'),
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
          selected: context.watch<CreateProvider>().createSelected,
          onTap: () {
            textCon = TextEditingController();
            isMore = false;
            dropDownValueType = textBarcodes.keys.first;
            context.read<CreateProvider>().createSelected == creates[index].name
                ? context.read<CreateProvider>().setCreate(creates[0].name)
                : context.read<CreateProvider>().setCreate(creates[index].name);
          },
        );
      },
    );
  }
}
