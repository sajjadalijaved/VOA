import 'dart:developer';
import 'datamodel_db.dart';
import '../modals/data_model.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<List<DataModel>> fetchData() async {
    Database? database = await DataModelDbHelper.getDb();
    List list = await database.query(DataModel.tableName);
    return list.map((map) => DataModel.fromMap(map)).toList();
  }
}
