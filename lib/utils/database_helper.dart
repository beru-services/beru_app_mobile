import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._createInstance();

  DatabaseHelper() {
    if (_databaseHelper == null) {
      DatabaseHelper._createInstance();
    }
  }

  Future<Database> get database async {
    return await _initializeDatabase();
  }

  Future<Database> _initializeDatabase() async {

    Database database = await openDatabase(
        join(await getDatabasesPath(), 'jaspe.db'),
        version: 1);
    return database;
  }
}

class DataBaseInterface {
  Future getObject(int id) async {}
  Future saveObject() async {}
}