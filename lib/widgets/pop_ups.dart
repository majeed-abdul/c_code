import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      content: Text(message, textAlign: TextAlign.center),
      duration: const Duration(milliseconds: 2500),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
