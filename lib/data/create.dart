import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class Item {
  String name;
  IconData icon;
  Item({required this.name, required this.icon});
}

// order os REQUIRED
List<Item> creates = [
  Item(name: 'TEXT & URL', icon: Icons.text_snippet_outlined),
  Item(name: 'NUMBERS', icon: Icons.numbers_outlined),
  Item(name: 'WIFI', icon: Icons.wifi_rounded),
  Item(name: 'CONTACT', icon: Icons.person_outline),
  Item(name: 'EMAIL', icon: Icons.email_outlined),
  Item(name: 'SMS', icon: Icons.sms_outlined),
  Item(name: 'Geo-Location', icon: Icons.location_on_outlined),
  Item(name: 'Phone', icon: Icons.call_end_outlined),
];

Map<String, Barcode> textBarcodes = {
  'QR Code': Barcode.qrCode(),
  'Data Matrix': Barcode.dataMatrix(),
  'Aztec': Barcode.aztec(),
  'PDF 417': Barcode.pdf417(),
  'Code 128': Barcode.code128(),
  'Telepen': Barcode.telepen(),
};
// for both index 0 must be Barcode.qrCode() .
Map<String, Barcode> numberBarcodes = {
  'QR Code': Barcode.qrCode(), //not for numbers its nessary to
  'Coda Bar': Barcode.codabar(),
  'Code 39': Barcode.code39(),
  'Code 93': Barcode.code93(),
  'EAN 13': Barcode.ean13(),
  'EAN 2': Barcode.ean2(),
  'EAN 5': Barcode.ean5(),
  'EAN 8': Barcode.ean8(),
  'ISBN': Barcode.isbn(),
  'upc A': Barcode.upcA(),
};

//--R11 index 0 of both maps must be Barcode.qrCode()

// REMOVED ONES
// Text
  // 'GS 128': Barcode.gs128(),
// Number
  // 'Data Matrix': Barcode.dataMatrix(),
  // 'Aztec': Barcode.aztec(),
  // 'PDF 417': Barcode.pdf417(),
  // 'Code 128': Barcode.code128(),
  // 'GS 128': Barcode.gs128(),
  // 'ITF 14': Barcode.itf14(),
  // 'ITF 16': Barcode.itf16(),
  // 'RM4SSC': Barcode.rm4scc(),
  // 'Telepen': Barcode.telepen(),
  // 'upc E': Barcode.upcE(),
  // 'ITF': Barcode.itf(),