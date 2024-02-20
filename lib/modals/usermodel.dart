// ignore_for_file: non_constant_identifier_names, unnecessary_this, prefer_collection_literals

class UserModel {
  String? user_id;
  String? userName;
  String? userLastName;
  String? userEmail;
  String? userPhoneNumber;

  UserModel(
      {this.user_id,
      this.userName,
      this.userLastName,
      this.userEmail,
      this.userPhoneNumber});

  UserModel.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    userName = json['userName'];
    userLastName = json['userLastName'];
    userEmail = json['userEmail'];
    userPhoneNumber = json['userPhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = user_id;
    data['userName'] = userName;
    data['userLastName'] = userLastName;
    data['userEmail'] = userEmail;
    data['userPhoneNumber'] = userPhoneNumber;
    return data;
  }
}
