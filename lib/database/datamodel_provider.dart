import 'dart:developer';
import 'datamodel_db.dart';
import '../modals/data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vacation_ownership_advisor/modals/contact_id_model.dart';

class DataModelProvider {
  Future<bool> insertData(DataModel dataModel) async {
    try {
      Database? database = await DataModelDbHelper.getDb();
      int result = await database.insert(
          DataModel.tableName, dataModel.toMap(dataModel),
          conflictAlgorithm: ConflictAlgorithm.replace);
      log('*************************Insert data*******************');

      if (result < 0) {
        return false;
      }
      return true;
    } catch (e) {
      log("insertData Error : $e");
      return false;
    }
  }

  Future<bool> insertContactId(ContactIdModel contactIdModel) async {
    try {
      Database? database = await DataModelDbHelper.getDbContact();

      // Check if table exists
      String createTable =
          'SELECT name FROM sqlite_master WHERE type = "table" AND name = "${ContactIdModel.tableContact}"';
      List<Map<String, dynamic>> results = await database.rawQuery(createTable);
      if (results.isEmpty) {
        // Table doesn't exist, create it
        await database.execute(ContactIdModel.create_table);
        log('Created contactId_tb table');
      }

      // Now insert data
      int result = await database.insert(
          ContactIdModel.tableContact, contactIdModel.toMap(contactIdModel),
          conflictAlgorithm: ConflictAlgorithm.replace);
      log('Insert data Contact Id: $result');
      return result >= 0;
    } catch (e) {
      log("insertData Contact Id Error : $e");
      return false;
    }
  }

  Future<bool> updateData(DataModel dataModel) async {
    try {
      Database? database = await DataModelDbHelper.getDb();
      int rows = await database.update(
          DataModel.tableName,
          {
            DataModel.key_firstName: dataModel.firstName,
            DataModel.key_email: dataModel.email,
            DataModel.key_phoneNumber: dataModel.phoneNumber
          },
          where: '${DataModel.key_userId} = ?',
          whereArgs: [dataModel.user_id]);
      log('*************************update data*******************');

      if (rows < 0) {
        return false;
      }
      return true;
    } catch (e) {
      log("update Error : $e");
      return false;
    }
  }

  Future<bool> updateContactId(ContactIdModel contactIdModel) async {
    try {
      Database? database = await DataModelDbHelper.getDbContact();
      int rows = await database.update(
          ContactIdModel.tableContact,
          {
            ContactIdModel.key_contactId: contactIdModel.contactId,
          },
          where: '${ContactIdModel.key_contact_userId} = ?',
          whereArgs: [contactIdModel.contact_user_Id]);
      log('*************************update Contact data*******************');

      if (rows < 0) {
        return false;
      }
      return true;
    } catch (e) {
      log("update Error : $e");
      return false;
    }
  }

  Future<bool> daleteOneDataItem(DataModel dataModel) async {
    try {
      Database? database = await DataModelDbHelper.getDb();
      int rows = await database.delete(DataModel.tableName,
          where: '${DataModel.key_phoneNumber} = ?',
          whereArgs: [dataModel.phoneNumber]);

      if (rows < 0) {
        return false;
      }
      return true;
    } catch (e) {
      log("daleteOneDataItem Error : $e");
      return false;
    }
  }

  Future<bool> daleteAllData(DataModel dataModel) async {
    try {
      Database? database = await DataModelDbHelper.getDb();
      int rows = await database.delete('dataModel_tb');

      if (rows < 0) {
        return false;
      }
      return true;
    } catch (e) {
      log("daleteAllData Error : $e");
      return false;
    }
  }

  Future<bool> daleteContactId() async {
    try {
      Database? database = await DataModelDbHelper.getDbContact();
      int rows = await database.delete(ContactIdModel.tableContact);
      log("@@@@@@@@@@@@@@@@@@@ Delete ContactId @@@@@@@@@@@@@@@@@");

      if (rows < 0) {
        return false;
      }
      return true;
    } catch (e) {
      log("tb_contact Error : $e");
      return false;
    }
  }

  Future<List<DataModel>> fetchData() async {
    Database? database = await DataModelDbHelper.getDb();
    List list = await database.query(DataModel.tableName);
    return list.map((map) => DataModel.fromMap(map)).toList();
  }

  Future<List<ContactIdModel>> fetchContactIdMethod() async {
    try {
      Database? database = await DataModelDbHelper.getDbContact();

      // Check if table exists
      String createTable =
          'SELECT name FROM sqlite_master WHERE type = "table" AND name = "${ContactIdModel.tableContact}"';
      List<Map<String, dynamic>> results = await database.rawQuery(createTable);
      if (results.isEmpty) {
        await database.execute(ContactIdModel.create_table);
        log('Created contactId_tb table');
      }
      List list = await database.rawQuery(ContactIdModel.fetch_data);
      return list.map((map) => ContactIdModel.fromMap(map)).toList();
    } catch (e) {
      log("fetchContactIdMethod Error: $e");
      return [];
    }
  }
}
