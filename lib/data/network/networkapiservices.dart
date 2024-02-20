import 'dart:io';
import 'dart:convert';
import 'baseapiservices.dart';
import '../app_exception.dart';
import 'package:http/http.dart';
// ignore_for_file: prefer_adjacent_string_concatenation

class NetworkApiServices extends BaseApiAServices {
  @override
  Future getGetApiResponse(String url, Map<String, String> headers) async {
    dynamic responseJson;
    try {
      final response = await get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = responseRequest(response);
    } on SocketException {
      throw FetchDataException('No Internet Exception');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 20));
      responseJson = responseRequest(response);
    } on SocketException {
      throw FetchDataException('No Internet Exception');
    }
    return responseJson;
  }

  @override
  Future getPostForgetApiResponse(
    String url,
    data,
  ) async {
    dynamic responseJson;
    try {
      final response = await post(
        Uri.parse(url),
        body: data,
      ).timeout(const Duration(seconds: 20));
      responseJson = responseRequest(response);
    } on SocketException {
      throw FetchDataException('No Internet Exception');
    }
    return responseJson;
  }
}

dynamic responseRequest(Response response) {
  switch (response.statusCode) {
    case 200 || 201:
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;

    case 400:
      throw BadRequestException(response.body.toString());
    case 404:
      throw UnAuthorizedException(response.body.toString());
    case 401:
      throw UnAuthorizedException(response.body.toString());
    case 403:
      throw Forbidden(response.body.toString());
    case 405:
      throw MethodNot(response.body.toString());
    case 413:
      throw RequesLarge(response.body.toString());
    case 500:
      throw InternalServerError(response.body.toString());

    default:
      throw FetchDataException(
          'Error occurred while communication with server' +
              'with status code' +
              response.statusCode.toString());
  }
}
