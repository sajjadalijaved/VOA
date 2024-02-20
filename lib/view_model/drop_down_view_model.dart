import 'package:flutter/material.dart';

class DropDownViewModel extends ChangeNotifier {
  String _dropdownValue = "";
  String _dropdownValueFlights = "";

  String get dropdownValue => _dropdownValue;
  String get dropdownValueFlights => _dropdownValueFlights;

  set dropDownValueMethod(String value) {
    _dropdownValue = value;
    notifyListeners();
  }

  set dropDownValueFlightsMethod(String value) {
    _dropdownValueFlights = value;
    notifyListeners();
  }
}
