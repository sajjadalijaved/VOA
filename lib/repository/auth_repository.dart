import 'appurl.dart';
import 'dart:developer';
import '../data/network/baseapiservices.dart';
import '../data/network/networkapiservices.dart';

// ignore_for_file: unnecessary_string_interpolations

// ignore_for_file: use_rethrow_when_possible

class AuthRepository {
  final BaseApiAServices _baseApiAServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic responce =
          await _baseApiAServices.getPostApiResponse(AppUlr.loginUrl, data);
      log("Login api response : $responce");
      return responce;
    } catch (e) {
      log("Login Api Error : $e");
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic responce =
          await _baseApiAServices.getPostApiResponse(AppUlr.registerUrl, data);
      log("Register api response : $responce");
      return responce;
    } catch (e) {
      log("Register Api Error : $e");
    }
  }

  Future<dynamic> forgetPasswordApi(dynamic data) async {
    try {
      dynamic responce = await _baseApiAServices.getPostApiResponse(
          AppUlr.forgetPasswordUrl, data);
      log("ForgetPassword api response : $responce");
      return responce;
    } catch (e) {
      log("ForgetPassword Api Error : $e");
    }
  }
}
