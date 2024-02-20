import 'package:flutter/material.dart';

class DropDownViewModel extends ChangeNotifier {
  String _dropdownValue = "";

  String get dropdownValue => _dropdownValue;

  set dropDownValueMethod(String value) {
    _dropdownValue = value;
    notifyListeners();
  }
}
