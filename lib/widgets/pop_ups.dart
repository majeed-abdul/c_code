import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      duration: const Duration(milliseconds: 2999),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

void joinBetaPopUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(10),
        title: const Text(
          'How to Join Beta?',
          textAlign: TextAlign.center,
        ),
        content: Image.asset(
          'assets/joinbeta.png',
          // width: 200,
          height: 200,
        ),
        actions: [
          OutlinedButton(
              style: const ButtonStyle(
                visualDensity: VisualDensity(vertical: -0.4),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(onPressed: () {}, child: const Text('Visit')),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      );
    },
  );
}
