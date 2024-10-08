import 'package:flutter/material.dart';

OutlinedButton customButton({
  required IconData icon,
  void Function()? onPress,
  Color color = Colors.black,
}) {
  return OutlinedButton(
    style: ButtonStyle(
      side: WidgetStatePropertyAll(
        BorderSide(width: 3, color: color),
      ),
      padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
      fixedSize: const WidgetStatePropertyAll(Size.square(55)),
      visualDensity: const VisualDensity(horizontal: -2.9, vertical: -2.9),
    ),
    onPressed: onPress,
    child: Icon(
      icon,
      color: color,
    ),
  );
}

// FilledButton gridButton({
//   required IconData icon,
//   required String label,
//   bool selected = false,
//   Function()? onTap,
// }) {
//   return FilledButton.icon(
//     onPressed: () => onTap,
//     icon: Icon(
//       icon,
//       color: selected ? null : Colors.black,
//     ),
//     label: Text(
//       label,
//       style: TextStyle(
//         color: selected ? null : Colors.black,
//       ),
//     ),
//     style: ButtonStyle(
//         backgroundColor: selected
//             ? null
//             : MaterialStateColor.resolveWith(
//                 (states) => Colors.white,
//               ),
//         side: selected
//             ? null
//             : MaterialStateBorderSide.resolveWith(
//                 (states) => const BorderSide(color: Colors.black54))),
//   );
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
Widget gridButton({
  required IconData icon,
  required String label,
  bool select = false,
  Function()? onTap,
}) {
  return FilledButton.icon(
    onPressed: onTap,
    icon: Icon(icon, color: !select ? Colors.black : null),
    label: Text(
      label,
      style: TextStyle(color: !select ? Colors.black : null),
    ),
    style: ButtonStyle(
      backgroundColor:
          !select ? const WidgetStatePropertyAll(Colors.white) : null,
      side: select
          ? const WidgetStatePropertyAll(BorderSide(color: Colors.white))
          : const WidgetStatePropertyAll(BorderSide(color: Colors.black87)),
    ),
  );
}
