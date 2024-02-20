import 'dart:developer';
import '../../Utils/utils.dart';
import '../user_view_model.dart';
import '../../modals/usermodel.dart';
import '../../modals/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../Utils/routes/routesname.dart';
import '../../database/datamodel_provider.dart';
import 'package:vacation_ownership_advisor/Screens/home_screen.dart';

// ignore_for_file: use_build_context_synchronously

class SplashServices {
  DataModelProvider dataModelProvider = DataModelProvider();
  Future<UserModel> getUserData() => UserViewModel().getUser();
  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      if (value.user_id.toString() == 'null' ||
          value.user_id.toString() == '') {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.checkConnectivityloginScreen, (route) => false);
      } else {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => CheckConnectivityHomeScreen(
                      userId: value.user_id.toString(),
                    )),
            (route) => false);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Utils.errorMessageFlush(error.toString(), context);
      }
    });
  }

  Future sendUserDataToDataBase(BuildContext context) async {
    await getUserData().then((value) async {
      await dataModelProvider.insertData(DataModel(
        user_id: value.user_id.toString(),
        firstName: value.userName.toString(),
        phoneNumber: value.userPhoneNumber.toString(),
        email: value.userEmail.toString(),
      ));
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        log(error.toString());
      }
    });
  }

  Future updateDataToDataBase(BuildContext context) async {
    await getUserData().then((value) async {
      await dataModelProvider.updateData(DataModel(
        user_id: value.user_id,
        firstName: value.userName.toString(),
        phoneNumber: value.userPhoneNumber.toString(),
        email: value.userEmail.toString(),
      ));
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        log(error.toString());
      }
    });
  }
}
