import '../Utils/utils.dart';
import 'user_view_model.dart';
import '../modals/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Utils/routes/routesname.dart';
import '../repository/auth_repository.dart';
import 'package:vacation_ownership_advisor/Screens/home_screen.dart';

// ignore_for_file: non_constant_identifier_names

// ignore_for_file: prefer_final_fields

class AuthViewModal with ChangeNotifier {
  final _myrepo = AuthRepository();

  bool _loginloading = false;
  bool _signinLoading = false;
  bool _forgetPasswordLoading = false;

  bool get loginloading => _loginloading;
  bool get signinLoading => _signinLoading;
  bool get forgetPasswordloading => _forgetPasswordLoading;

  setLoginLoading(bool value) {
    _loginloading = value;
    notifyListeners();
  }

  signInLoading(bool value) {
    _signinLoading = value;
    notifyListeners();
  }

  forgetPasswordLoading(bool value) {
    _forgetPasswordLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoginLoading(true);
    _myrepo.loginApi(data).then((value) {
      setLoginLoading(false);
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(UserModel(
          user_id: value['user_id'].toString(),
          userName: value['user_data']['first_name'].toString(),
          //userLastName: value['user_data']['last_name'].toString(),
          userEmail: value['user_data']['email'],
          userPhoneNumber: value['user_data']['mobile'].toString()));

      String status = value['status'];
      String msg = value['message'];
      dynamic user_id = value['user_id'];

      if (status == "success") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => CheckConnectivityHomeScreen(
                      userId: user_id,
                    )),
            (route) => false);
        Utils.successMessageFlush(msg.toString(), context);
      } else {
        Utils.errorMessageFlush(msg.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoginLoading(false);

      Utils.errorMessageFlush("Invalid Password Or Email", context);
    });
  }

  Future<void> registerApi(dynamic data, BuildContext context) async {
    signInLoading(true);
    _myrepo.registerApi(data).then((value) {
      signInLoading(false);
      String message = value["message"].toString();

      if (message == "Registration successfully completed!") {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.checkConnectivityloginScreen, (route) => false);
        Utils.successMessageFlush(message.toString(), context);
      } else {
        Utils.errorMessageFlush(message.toString(), context);
      }
    }).onError((error, stackTrace) {
      signInLoading(false);

      Utils.errorMessageFlush(
          "User with this email already exists.".toString(), context);
    });
  }

  Future<void> forgetPasswordApi(dynamic data, BuildContext context) async {
    forgetPasswordLoading(true);
    _myrepo.forgetPasswordApi(data).then((value) {
      forgetPasswordLoading(false);
      String status = value['status'];
      String message = value["message"].toString();

      if (status == "success") {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.checkConnectivityloginScreen, (route) => false);
        Utils.successMessageFlush(
            'Password Successfully Send To Your Email '.toString(), context);
      } else {
        Utils.errorMessageFlush(message.toString(), context);
      }
    }).onError((error, stackTrace) {
      forgetPasswordLoading(false);

      Utils.errorMessageFlush(
          "User not found for the provided email.", context);
    });
  }
}
