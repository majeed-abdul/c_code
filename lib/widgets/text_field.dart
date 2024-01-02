import 'package:flutter/material.dart';

InputDecoration kDecoration = const InputDecoration(
  filled: true,
  fillColor: Colors.white,
  contentPadding: EdgeInsets.all(8),
  hintStyle: TextStyle(fontSize: 15),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff999999), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff999999), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
);
Widget entryBar({Widget? child, String? text}) {
  return ListTile(
    contentPadding: const EdgeInsets.all(0),
    minLeadingWidth: 88,
    horizontalTitleGap: 7,
    leading: Text(
      '$text :',
      style: const TextStyle(
        height: 1.7,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    title: child,
  );
}
