import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:c_code/widgets/buttons.dart';
import 'package:c_code/widgets/pop_ups.dart';
import 'package:flutter/foundation.dart';
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
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => scrollCon.animateTo(
              scrollCon.position.maxScrollExtent,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 1500),
            ));

    super.initState();
  }

  String test =
      'Dear Student Download a research paper having 3 or more impact factors related to software reengineering, write review of said paper and submit it along with downloaded paper on LMS. Review: The need of reengineering is started from 1990s. This happens when users need to shift their data from legacy systems to new systems like web. Reengineering is started from source code of current system and ends with source code of new system. And it can be easily done with translation tools it becomes very complex, when we need to change some design factor s and architecture.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(describeEnum(widget.result.format)),
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
              const Text('Text',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              resultText(),
              const SizedBox(height: 20),
              buttonsRow(),
              buttonsLabelRow(),
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

  Row buttonsLabelRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 55,
          child: Text('Browse', textAlign: TextAlign.center),
        ),
        SizedBox(
          width: 55,
          child: Text('Copy', textAlign: TextAlign.center),
        ),
      ],
    );
  }

  Row buttonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        customButton(
          onPress: () => _browse(),
          icon: const Icon(Icons.link),
        ),
        customButton(
          onPress: () => _copy(),
          icon: const Icon(Icons.copy),
        ),
      ],
    );
  }

  Container resultText() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(9),
      child: SelectableText('${widget.result.code}',
          style: const TextStyle(fontSize: 15)),
    );
  }

  void _copy() async {
    await Clipboard.setData(
      ClipboardData(text: widget.result.code),
    ).then(
      (value) => showSnackBar(context, 'Coppied'),
    );
  }

  void _browse() {}
}
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       'Data  :${result?.code}',
        //       style: const TextStyle(color: Colors.white),
        //     ),
        //     Text(
        //       'Format:${result?.format == null ? '' : describeEnum(result!.format)}',
        //       style: const TextStyle(color: Colors.white),
        //     ),
        //   ],
        // ),