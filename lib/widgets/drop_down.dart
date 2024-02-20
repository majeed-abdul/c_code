import 'package:flutter/material.dart';
import 'package:qr_maze/widgets/text_field.dart';

Widget dropDown({
  required List<String> items,
  required void Function(String?)? onChanged,
  String? dropDownValue,
  String? text,
  String? hint,
}) {
  return entryBar(
    text: text,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xff999999), width: 1),
      ),
      child: DropdownButton<String>(
        borderRadius: BorderRadius.circular(6),
        focusColor: Colors.white,
        hint: Text(hint ?? 'null'),
        value: dropDownValue,
        isExpanded: true,
        elevation: 16,
        onChanged: onChanged,
        underline: const SizedBox(),
        style: const TextStyle(color: Colors.black, fontSize: 15),
        icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 30),
        items: items
            .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ),
            )
            .toList(),
      ),
    ),
  );
}
