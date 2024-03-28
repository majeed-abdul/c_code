import 'package:flutter/material.dart';

Container customButton({
  required IconData icon,
  void Function()? onPress,
  Color color = Colors.black,
}) {
  return Container(
    height: 55,
    width: 55,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(69),
      border: Border.all(color: color, width: 3),
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(69),
      onTap: onPress,
      child: Icon(icon, color: color),
    ),
  );
}

Widget gridButton({
  required IconData icon,
  required String name,
  bool selected = false,
  Function()? onTap,
}) {
  return FilledButton.icon(
    onPressed: () => onTap,
    icon: Icon(
      icon,
      color: selected ? null : Colors.black,
    ),
    label: Text(
      name,
      style: TextStyle(
        color: selected ? null : Colors.black,
      ),
    ),
    style: ButtonStyle(
        backgroundColor: selected
            ? null
            : MaterialStateColor.resolveWith(
                (states) => Colors.white,
              ),
        side: selected
            ? null
            : MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(color: Colors.black54))),
  );
  // return InkWell(
  //   borderRadius: BorderRadius.circular(7),
  //   onTap: onTap,
  //   child: Stack(
  //     children: [
  //       Container(
  //         width: double.maxFinite,
  //         height: double.maxFinite,
  //         padding: const EdgeInsets.all(5),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(7),
  //           border: Border.all(),
  //         ),
  //         child: Row(
  //           children: [
  //             Icon(icon, size: 30),
  //             const SizedBox(width: 5),
  //             Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
  //           ],
  //         ),
  //       ),
  //       Visibility(
  //         visible: selected,
  //         child: Container(
  //           margin: const EdgeInsets.all(1),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(7),
  //             color: const Color(0x44000000),
  //           ),
  //         ),
  //       ),
  //     ],
  //   ),
  // );
}
