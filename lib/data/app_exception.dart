// ignore_for_file: prefer_typing_uninitialized_variables, unused_field

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error During Communication');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message])
      : super(message, 'UnAuthorized request');
}

class MethodNot extends AppException {
  MethodNot([String? message]) : super(message, 'Method Not Allowed');
}

class RequesLarge extends AppException {
  RequesLarge([String? message]) : super(message, 'Request Entity Too Large');
}

class Forbidden extends AppException {
  Forbidden([String? message]) : super(message, 'Forbidden');
}

class InternalServerError extends AppException {
  InternalServerError([String? message]) : super(message, 'Forbidden');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}
