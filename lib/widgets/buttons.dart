import 'package:flutter/material.dart';

Container customButton({
  required void Function() onPress,
  required IconData icon,
  Color color = Colors.black,
}) {
  return Container(
    width: 55,
    height: 55,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(69),
      border: Border.all(color: color, width: 3),
    ),
    // child: IconButton(
    //   iconSize: 30,
    //   icon: icon,
    //   color: color,
    //   onPressed: onPress,
    // ),
    child: GestureDetector(onTap: onPress, child: Icon(icon, color: color)),
  );
}

GestureDetector gridButton({
  required IconData icon,
  required String name,
  String? selected,
  Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            // color: kButtonColor,
            border: Border.all(),
          ),
          child: Row(
            children: [
              Icon(icon, size: 30),
              const SizedBox(width: 5),
              Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: selected == name,
          child: Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0x44000000),
            ),
          ),
        ),
      ],
    ),
  );
}
