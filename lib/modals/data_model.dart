// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class DataModel {
  String? user_id;
  String? firstName;
  String? email;
  String? phoneNumber;
  String? contactId;

  static const String dbName = "dataModel.db";
  static const String tableName = "dataModel_tb";

  static const String key_userId = 'user_id';
  static const String key_firstName = 'firstName';
  static const String key_phoneNumber = 'phoneNumber';
  static const String key_email = 'email';

  static const String create_table =
      'CREATE TABLE  $tableName($key_userId TEXT PRIMARY KEY, $key_phoneNumber TEXT, $key_firstName TEXT, $key_email TEXT,)';
  static const String drop_table = 'DROP TABLE IF EXISTS $tableName';
  static const String fetch_data = 'SELECT *FROM $tableName';

  DataModel({this.user_id, this.firstName, this.phoneNumber, this.email});

  Map<String, dynamic> toMap(DataModel dataModel) {
    return {
      DataModel.key_userId: dataModel.user_id,
      DataModel.key_firstName: dataModel.firstName,
      DataModel.key_phoneNumber: dataModel.phoneNumber,
      DataModel.key_email: dataModel.email,
    };
  }

  DataModel.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    firstName = map['firstName'];
    phoneNumber = map['phoneNumber'];
    email = map['email'];
  }
}
