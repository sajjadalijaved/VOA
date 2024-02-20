import 'appurl.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

// ignore_for_file: unnecessary_string_interpolations

// global variables
String? email1;
String? id;
String? token;

// accessToken method

Future accesstoken() async {
  try {
    Response response = await post(Uri.parse(AppUlr.accessTokenUrl), body: {
      'refresh_token':
          "1000.cb5f95ea684127b48a38729466ab215f.bee2edbe5af5f63c1af442bb8b5833dd",
      'client_id': "1000.CXLGX66Z8FKYSBUVCX7LCW56CQ1T7H",
      'client_secret': "6fcbc739a5f214f523da44191414a3a6078dcce8be",
      'grant_type': "refresh_token"
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log("AccessData : $data");
      token = data['access_token'];
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

Future senddata(
    {required String firstname,
    required String email,
    required String phonenumber,
    required String latitude,
    required String longitude}) async {
  try {
    log("token : $token");
    Map<String, String> headers = {"Authorization": "Zoho-oauthtoken $token"};
    Map<String, dynamic> data = {
      "data": [
        {
          "Name": "$firstname",
          "Email": "$email",
          "Phone": "$phonenumber",
          "Latitude": "$latitude",
          "Longitude": "$longitude"
        },
      ],
    };
    var response = await post(
        Uri.parse(
          AppUlr.sendDataUrl,
        ),
        body: jsonEncode(data),
        headers: headers);

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      log("sendData : $data");
    } else {
      log("Error :${response.statusCode}");
    }
  } catch (e) {
    if (kDebugMode) {
      log("err0r : $e");
    }
  }
}

// search user through email method
Future getSearchThroughEmail({required String email}) async {
  try {
    Map<String, String> headers = {"Authorization": "Zoho-oauthtoken $token"};
    var response = await get(
        Uri.parse(
            "https://www.zohoapis.com/crm/v5/Application_Data/search?email=$email"),
        headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      log("Get Email Data : $data");
      email1 = data['data'][0]['Email'];
      id = data['data'][0]['id'];
      log("Get Email Data1 : $email1");
      log("ID Data : $id");
    } else {
      log("response statusCode :${response.statusCode}");
    }
  } catch (e) {
    log("err0r : $e");
  }
}

// update data method
Future updateData({required String latitude, required String longitude}) async {
  try {
    Map<String, String> headers = {"Authorization": "Zoho-oauthtoken $token"};
    Map<String, dynamic> data = {
      "data": [
        {"Latitude": "$latitude", "Longitude": "$longitude"},
      ],
    };
    var response = await put(
        Uri.parse("https://www.zohoapis.com/crm/v2/Application_Data/$id"),
        body: jsonEncode(data),
        headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      log("UpdateData : $data");
    } else {
      log("Error :${response.statusCode}");
    }
  } catch (e) {
    log("err0r : $e");
  }
}

// get email method
String? getEmail() {
  return email1;
}
