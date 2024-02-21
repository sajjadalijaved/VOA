import 'package:flutter/material.dart';

class ErrorModelClass extends ChangeNotifier {
  String _errorText = '';
  String _errorCarText = '';
  String _errorFlightsText = '';
  String _errorCruiseText = '';
  String _errorTourText = '';

  String get errorText => _errorText;
  String get errorCarText => _errorCarText;
  String get errorFlightsText => _errorFlightsText;
  String get errorCruiseText => _errorCruiseText;
  String get errorTourText => _errorTourText;

  void setErrorText(String error) {
    _errorText = error;
    notifyListeners();
  }

  void setErrorCarText(String error) {
    _errorCarText = error;
    notifyListeners();
  }

  void setErrorFlightsText(String error) {
    _errorFlightsText = error;
    notifyListeners();
  }

  void setErrorCruiseText(String error) {
    _errorCruiseText = error;
    notifyListeners();
  }

  void setErrorTourText(String error) {
    _errorTourText = error;
    notifyListeners();
  }
}
