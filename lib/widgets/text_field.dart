import 'package:flutter/material.dart';

// InputDecoration kDecoration = const InputDecoration(
//   filled: true,
//   fillColor: Colors.white,
//   contentPadding: EdgeInsets.all(8),
//   hintStyle: TextStyle(fontSize: 15),
//   errorBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(6.0)),
//     borderSide: BorderSide(color: Colors.red, width: 1.0),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(6.0)),
//     borderSide: BorderSide(color: Color(0xff999999), width: 1.0),
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(6.0)),
//     borderSide: BorderSide(color: Color(0xff999999), width: 1.0),
//   ),
// );
Widget entryBar({Widget? child, String? text}) {
  return ListTile(
    title: child,
    horizontalTitleGap: 7,
    minLeadingWidth: 88,
    contentPadding: const EdgeInsets.all(0),
    leading: Text(
      '$text :',
      style: const TextStyle(
        fontSize: 16,
        height: 1.7,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
