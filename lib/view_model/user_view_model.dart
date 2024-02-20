import '../modals/usermodel.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore_for_file: unused_local_variable

// ignore_for_file: non_constant_identifier_names

class UserViewModel extends ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('user_id', user.user_id.toString());
    sp.setString('userName', user.userName.toString());
    sp.setString('userLastName', user.userLastName.toString());
    sp.setString('userEmail', user.userEmail.toString());
    sp.setString('userPhoneNumber', user.userPhoneNumber.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? user_id = sp.getString('user_id');
    String? userName = sp.getString('userName');
    String? userLastName = sp.getString('userLastName');
    String? userEmail = sp.getString('userEmail');
    String? userPhoneNumber = sp.getString('userPhoneNumber');
    return UserModel(
        user_id: user_id.toString(),
        userName: userName.toString(),
        userLastName: userLastName.toString(),
        userEmail: userEmail.toString(),
        userPhoneNumber: userPhoneNumber.toString());
  }

  Future<bool> remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('user_id');
    return true;
  }
}
