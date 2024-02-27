import 'dart:developer';
import 'package:path/path.dart';
import '../modals/data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vacation_ownership_advisor/modals/contact_id_model.dart';
// ignore_for_file: constant_identifier_names

// ignore_for_file: depend_on_referenced_packages

class DataModelDbHelper {
  static Database? _database;

  static Future<Database> getDb() async {
    _database ??= await openDatabase(
      join(await getDatabasesPath(), DataModel.dbName),
      onCreate: (db, version) {
        db.execute(DataModel.create_table);
        log('******************OnCreate^^^^^^^^^^^^^^^^^^^^^^^^^ ');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion != newVersion) {
          db.execute(DataModel.drop_table);
          db.execute(DataModel.create_table);
        }
      },
      version: 1,
    );
    return _database!;
  }

  static Future<Database> getDbContact() async {
    _database ??= await openDatabase(
      join(await getDatabasesPath(), ContactIdModel.dbContactId),
      onCreate: (db, version) {
        db.execute(ContactIdModel.create_table);
        log('Table created successfully');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion != newVersion) {
          if (oldVersion < 2) {
            // Add a new column
            db.execute(
                'ALTER TABLE ${ContactIdModel.tableContact} ADD COLUMN newColumn TEXT');
          }
        }
      },
      version: 2,
    );
    return _database!;
  }
}
