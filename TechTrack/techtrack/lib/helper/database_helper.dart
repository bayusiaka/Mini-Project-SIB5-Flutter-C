// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
import 'package:techtrack/models/user_model.dart';

class DatabaseHelper {
  final databaseName = "user.db";

  String users =
      "create table users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT UNIQUE, usrPassword TEXT)";

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
    });
  }

  Future<bool> login(UserModel userModel) async {
    final Database db = await initDB();

    var result = await db.rawQuery(
        "select * from users where usrName = '${userModel.usrName}' AND usrPassword = '${userModel.usrPassword}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> signup(UserModel userModel) async {
    final Database db = await initDB();

    return db.insert('users', userModel.toMap());
  }

  updateAccount(int userId, String newUsername, String newPassword) {}
}