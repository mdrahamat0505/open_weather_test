import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static Database? _db;
  static const String DB_NAME = 'local_table.db';

  LocalDatabase() {
    db;
  }

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    return await initDB();
  }

  Future initDB() async {
    io.Directory appDirectory = await getApplicationDocumentsDirectory();
    String path = join(appDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE weather"
      "("
      "id integer primary key autoincrement, "
      "condition text, "
      "temperature integer, "
      "feelsLike integer, "
      "pressure integer, "
      "visibility integer, "
      "humidity text, "
      "windSpeed double, "
      "country text, "
      "name text, "
      "icon text "
      ")",
    );
  }
}
