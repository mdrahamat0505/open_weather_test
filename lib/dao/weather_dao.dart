import 'package:open_weather_test/dao/local_database.dart';

import '../models/weather_model.dart';

class WeatherDAO {
  LocalDatabase? localDatabase;
  static const TABLE = 'weather';

  WeatherDAO() {
    localDatabase = LocalDatabase();
  }

  Future<WeatherModel?> save(WeatherModel model) async {
    try {
      final dbClient = await localDatabase?.db;
      final Map<String, dynamic> map = model.toMap();
      model.id = await dbClient?.insert(TABLE, map);
      return model;
    } catch (e) {
      return null;
    }
  }
  //
  // Future<WeatherModel?> get(int id) async {
  //   final dbClient = await localDatabase?.db;
  //   final   maps = await dbClient?.query(TABLE, where: 'id = ?', whereArgs: [id]);
  //
  //   if (maps != null && maps.isNotEmpty) {
  //     final WeatherModel model = WeatherModel.fromMap(maps[0]);
  //     return model;
  //   } else {
  //     return null;
  //   }
  // }

  Future<WeatherModel?> get() async {
    var dbClient = await localDatabase?.db;
    List<Map>? maps = await dbClient?.query(TABLE);
    WeatherModel? model;
    if (maps!.length > 0) {
      model = WeatherModel.fromMap(maps[0]);
    }
    return model;
  }

  Future<int?> delete(int id) async {
    final dbClient = await localDatabase?.db;
    return await dbClient?.delete(TABLE, where: 'id = ?', whereArgs: [id]);
  }

  Future<int?> deleteAll() async {
    final dbClient = await localDatabase?.db;
    return await dbClient?.delete(TABLE);
  }
}
