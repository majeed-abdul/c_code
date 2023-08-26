import 'package:flutter/material.dart';
import 'package:c_code/data/create.dart';

class CreateProvider extends ChangeNotifier {
  String createSelected = creates[0].name;
  setCreate(String name) {
    createSelected = name;
    notifyListeners();
  }
}
