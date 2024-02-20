import 'package:flutter/material.dart';

class TextFieldColorChangeViewModel extends ChangeNotifier {
  Color _emailFieldColor = Colors.black26;
  Color _emailForgetFieldColor = Colors.black26;
  Color _emailSignUpFieldColor = Colors.black26;
  Color _passwordFieldColor = Colors.black26;
  Color _passwordSignUpFieldColor = Colors.black26;
  Color _phoneFieldColor = Colors.black26;
  Color _confirmFieldColor = Colors.black26;
  Color _nameFieldColor = Colors.black26;
  Color _checkInFieldColor = Colors.black26;
  Color _checkOutFieldColor = Colors.black26;
  Color _pickDateieldColor = Colors.black26;
  Color _pickTimeFieldColor = Colors.black26;
  Color _dropDateFieldColor = Colors.black26;
  Color _dropTimeFieldColor = Colors.black26;
  Color _fromDateFieldColor = Colors.black26;
  Color _toFieldColor = Colors.black26;
  Color _sailingDateFieldColor = Colors.black26;
  Color _returnFieldColor = Colors.black26;
  Color _startingDateFieldColor = Colors.black26;
  Color _endingDateFieldColor = Colors.black26;

  Color get emailFieldColor => _emailFieldColor;
  Color get emailSignUpFieldColor => _emailSignUpFieldColor;
  Color get emailForgetFieldColor => _emailForgetFieldColor;
  Color get passwordFieldColor => _passwordFieldColor;
  Color get passwordSignUpFieldColor => _passwordSignUpFieldColor;
  Color get nameFieldColor => _nameFieldColor;
  Color get passwordConfirmFieldColor => _confirmFieldColor;
  Color get phoneFieldColor => _phoneFieldColor;
  Color get checkInFieldColor => _checkInFieldColor;
  Color get checkOutFieldColor => _checkOutFieldColor;
  Color get pickDateFieldColor => _pickDateieldColor;
  Color get pickTimeFieldColor => _pickTimeFieldColor;
  Color get dropDateColor => _dropDateFieldColor;
  Color get dropTimeFieldColor => _dropTimeFieldColor;
  Color get fromDateColor => _fromDateFieldColor;
  Color get toFieldColor => _toFieldColor;
  Color get sailingDateFieldColor => _sailingDateFieldColor;
  Color get returnDateFieldColor => _returnFieldColor;
  Color get startDateFieldColor => _startingDateFieldColor;
  Color get endingDateFieldColor => _endingDateFieldColor;

  void setEmailFieldColor(Color color) {
    _emailFieldColor = color;
    notifyListeners();
  }

  void setEmailSignUpFieldColor(Color color) {
    _emailSignUpFieldColor = color;
    notifyListeners();
  }

  void setEmailForgetFieldColor(Color color) {
    _emailForgetFieldColor = color;
    notifyListeners();
  }

  void setPasswordFieldColor(Color color) {
    _passwordFieldColor = color;
    notifyListeners();
  }

  void setPassworSignUpdFieldColor(Color color) {
    _passwordSignUpFieldColor = color;
    notifyListeners();
  }

  void setPasswordConfirmFieldColor(Color color) {
    _confirmFieldColor = color;
    notifyListeners();
  }

  void setPhoneFieldColor(Color color) {
    _phoneFieldColor = color;
    notifyListeners();
  }

  void setNameFieldColor(Color color) {
    _nameFieldColor = color;
    notifyListeners();
  }

  void setCheckInFieldColor(Color color) {
    _checkInFieldColor = color;
    notifyListeners();
  }

  void setCheckOUtFieldColor(Color color) {
    _checkOutFieldColor = color;
    notifyListeners();
  }

  void setPickDateFieldColor(Color color) {
    _pickDateieldColor = color;
    notifyListeners();
  }

  void setPickTimeFieldColor(Color color) {
    _pickTimeFieldColor = color;
    notifyListeners();
  }

  void setDropDateFieldColor(Color color) {
    _dropDateFieldColor = color;
    notifyListeners();
  }

  void setDropTimeFieldColor(Color color) {
    _dropTimeFieldColor = color;
    notifyListeners();
  }

  void setFromDateFieldColor(Color color) {
    _fromDateFieldColor = color;
    notifyListeners();
  }

  void setToDateFieldColor(Color color) {
    _toFieldColor = color;
    notifyListeners();
  }

  void setSailingDateFieldColor(Color color) {
    _sailingDateFieldColor = color;
    notifyListeners();
  }

  void setReturnDateFieldColor(Color color) {
    _returnFieldColor = color;
    notifyListeners();
  }

  void setStartDateFieldColor(Color color) {
    _startingDateFieldColor = color;
    notifyListeners();
  }

  void setEndingDateFieldColor(Color color) {
    _endingDateFieldColor = color;
    notifyListeners();
  }
}
