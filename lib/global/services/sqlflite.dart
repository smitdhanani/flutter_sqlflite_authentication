import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqlflite_authentication/model/user_model.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        date TEXT NOT NULL,
        time TEXT NOT NULL
      )
      """);
  }

  Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbtech.db',
      version: 3,
      onCreate: (sql.Database database, int version) async {
        await database.execute(users);
        await createTables(database);
      },
    );
  }

  Future<bool> login(Users user) async {
    final sql.Database dbb = await db();

    var result = await dbb.rawQuery(
        "select * from users where userName ='${user.userName}' AND userPassword ='${user.userPassword}'");

    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String users =
      "CREATE TABLE users(userId INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT UNIQUE, userPassword TEXT)";

  Future<int> register(Users user) async {
    final sql.Database dbb = await db();

    return dbb.insert('users', user.toMap());
  }
}
