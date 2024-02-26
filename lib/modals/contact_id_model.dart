// ignore_for_file: non_constant_identifier_names, constant_identifier_names

class ContactIdModel {
  String? contactId;
  String? contact_user_Id;

  static const String dbContactId = "contactIdModel.db";
  static const String tableContact = "contactId_tb";

  static const String key_contactId = 'contactId';
  static const String key_contact_userId = 'contactUserId';

  static const String create_table =
      'CREATE TABLE $tableContact($key_contact_userId TEXT, $key_contactId TEXT)';
  static const String drop_table = 'DROP TABLE IF EXISTS $tableContact';
  static const String fetch_data = 'SELECT *FROM $tableContact';

  ContactIdModel({required this.contactId, required this.contact_user_Id});

  Map<String, dynamic> toMap(ContactIdModel contactIdModel) {
    return {
      ContactIdModel.key_contactId: contactIdModel.contactId,
      ContactIdModel.key_contact_userId: contactIdModel.contact_user_Id,
    };
  }

  ContactIdModel.fromMap(Map<String, dynamic> map) {
    contactId = map['contactId'];
    contact_user_Id = map["contactUserId"];
  }
}
