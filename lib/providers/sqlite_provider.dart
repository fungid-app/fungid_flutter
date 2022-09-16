import 'package:fungid_flutter/domain/sqlite.dart';
import 'package:sqflite/sqlite_api.dart';

class SqliteProvider {
  const SqliteProvider(
    Database db,
  ) : _db = db;

  final Database _db;

  Future<List<ClassifierSpecies>> getSpecies() async {
    var result = await _db.rawQuery('SELECT * FROM species');

    return result.map((e) => ClassifierSpecies.fromMap(e)).toList();
  }
}
