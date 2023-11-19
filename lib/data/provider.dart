import 'package:c_code/data/create.dart';
import 'package:flutter/material.dart';

class CreateProvider extends ChangeNotifier {
  String createSelected = creates[0].name;
  setCreate(String name) {
    createSelected = name;
    notifyListeners();
  }
}
