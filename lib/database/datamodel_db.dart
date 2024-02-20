import 'dart:developer';
import 'package:path/path.dart';
import '../modals/data_model.dart';
import 'package:sqflite/sqflite.dart';

// ignore_for_file: depend_on_referenced_packages

class DataModelDbHelper {
  static Database? database;

  static Future<Database> getDb() async {
    if (database == null) {
      database =
          await openDatabase(join(await getDatabasesPath(), DataModel.dbName),
              onCreate: (db, version) {
        db.execute(DataModel.create_table);
        log('******************OnCreate^^^^^^^^^^^^^^^^^^^^^^^^^ ');
      }, onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion != newVersion) {
          db.execute(DataModel.drop_table);
          db.execute(DataModel.create_table);
        }
      }, version: 1);
      return Future.value(database);
    }
    return Future.value(database);
  }
}
