import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

List<Item> creates = [
  Item(name: 'TEXT & URL', icon: Icons.text_snippet_outlined),
  Item(name: 'NUMBERS', icon: Icons.numbers_outlined),
  Item(name: 'WIFI', icon: Icons.wifi_rounded),
  Item(name: 'V-CARD', icon: Icons.person_outline),
  Item(name: 'EMAIL', icon: Icons.email_outlined),
  Item(name: 'SMS', icon: Icons.sms_outlined),
];

Map<String, Barcode> textBarcodes = {
  'QR Code': Barcode.qrCode(),
  'Data Matrix': Barcode.dataMatrix(),
  'Aztec': Barcode.aztec(),
  'PDF 417': Barcode.pdf417(),
  'Code 128': Barcode.code128(),
  // 'GS 128': Barcode.gs128(),
  'Telepen': Barcode.telepen(),
};

Map<String, Barcode> numberBarcodes = {
  // 'QR Code': Barcode.qrCode(),
  // 'Data Matrix': Barcode.dataMatrix(),
  // 'Aztec': Barcode.aztec(),
  // 'PDF 417': Barcode.pdf417(),
  'Coda Bar': Barcode.codabar(),
  // 'Code 128': Barcode.code128(),
  'Code 39': Barcode.code39(),
  'Code 93': Barcode.code93(),
  'EAN 13': Barcode.ean13(),
  'EAN 2': Barcode.ean2(),
  'EAN 5': Barcode.ean5(),
  'EAN 8': Barcode.ean8(),
  // 'GS 128': Barcode.gs128(),
  'ISBN': Barcode.isbn(),
  'ITF': Barcode.itf(),
  // 'ITF 14': Barcode.itf14(),
  // 'ITF 16': Barcode.itf16(),
  // 'RM4SSC': Barcode.rm4scc(),
  // 'Telepen': Barcode.telepen(),
  'upc A': Barcode.upcA(),
  'upc E': Barcode.upcE(),
};

class Item {
  String name;
  IconData icon;
  Item({required this.name, required this.icon});
}
