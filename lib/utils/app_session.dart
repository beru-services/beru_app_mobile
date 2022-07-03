import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class AppSession extends DatabaseHelper implements DataBaseInterface {
  static bool isLoggedIn = false;
  static late ModelSession user;

  Future register(ModelSession data) async {
    print("rrrrr");
    try {
      user = data;
      await deleteObject();
      await saveObject();

    } catch (e) {
      print(e);
      print("==== ERROR ===");
      // await _createTable();
    }
  }

  Future unregister() async {
    user = ModelSession();

    await deleteObject();
    return true;
  }

  Future<bool> isActiveSession() async {
    try {
      user = await getObject(1);

      if (user.userId is int) {
        AppSession.isLoggedIn = true;
        return true;
      }
    } catch (e) {
      print('===== new phone ===');
      await _createTable();
    }


    AppSession.isLoggedIn = false;
    return false;
  }

  Future deleteObject() async {
    final db = await database;
    print("delete");
    await db.delete('user');
  }

  @override
  Future getObject(int id) async {
    Database db = await database;

    List<Map> maps = await db.query('user',
        columns: ['*'], where: "id = ?", whereArgs: [id]);
    if (!maps.isNotEmpty) {
      return null;
    }

    AppSession.isLoggedIn = true;
    var data = json.decode(json.encode(maps.first));

    return ModelSession.fromJson(data);
  }

  @override
  Future<int> saveObject() async {
    Database db = await database;
    return await db.insert('user', user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<bool> _createTable() async {
    Database db = await database;
    db.execute("DROP TABLE IF EXISTS user;");
    db.execute(
      "CREATE TABLE user(id INTEGER PRIMARY KEY, "
      "token TEXT,"
      "user_type TEXT,"
      "user_id INTEGER)",
    );
    return true;
  }
}

class ModelSession {
  String? token;
  String? userType;
  int? userId;

  ModelSession({this.token, this.userType, this.userId});

  ModelSession.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userType = json['user_type'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['user_type'] = userType;
    data['user_id'] = userId;
    return data;
  }
}
