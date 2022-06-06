import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class AppSession extends DatabaseHelper implements DataBaseInterface {
  static bool isLoggedIn = false;
  static late ModelSession user;

  Future register(ModelSession data) async {
    await deleteObject();
    await saveObject();
    user = data;
  }

  Future unregister() async {
    user = ModelSession();

    await deleteObject();
    return true;
  }

  Future<bool> isActiveSession() async {
    var dataUser = await getObject(1);
    if (dataUser == null) {
      AppSession.isLoggedIn = false;
      return false;
    } else {
      AppSession.isLoggedIn = true;
      return true;
    }
  }
  Future deleteObject() async {
    final db = await database;

    await db.delete('user');
  }

  @override
  Future getObject(int id) async {
    Database db = await database;
    try {
      List<Map> maps = await db.query('user',
          columns: ['*'], where: "id = ?", whereArgs: [id]);
      if (!maps.isNotEmpty) {
        return null;
      }

      AppSession.isLoggedIn = true;
      var data = json.decode(json.encode(maps.first));

      return ModelSession().fromJson(data);

    } catch (e) {
      print("==== Es un nuevo celular ===");
      await _createTable();
      return null;
    }
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
      "CREATE TABLE cliente(id INTEGER PRIMARY KEY, "
          "token TEXT,"
          "user_type TEXT,"
          "user_id INTEGER)",
    );
    return true;
  }

}


class ModelSession {
  late String token;
  late String userType;
  late int userId;

  fromJson(Map<String, dynamic> json) {
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
