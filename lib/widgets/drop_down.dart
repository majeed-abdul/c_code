import 'package:c_code/widgets/text_field.dart';
import 'package:flutter/material.dart';

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
        hint: Text(hint ?? 'null'),
        borderRadius: BorderRadius.circular(6),
        focusColor: Colors.white,
        isExpanded: true,
        value: dropDownValue,
        elevation: 16,
        style: const TextStyle(color: Colors.black, fontSize: 15),
        underline: const SizedBox(),
        onChanged: onChanged,
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
