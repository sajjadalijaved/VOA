import 'package:flutter/material.dart';

class ErrorModelClass extends ChangeNotifier {
  String _errorText = '';

  String get errorText => _errorText;

  void setErrorText(String error) {
    _errorText = error;
    notifyListeners();
  }
}
