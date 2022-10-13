import 'dart:io';

import 'package:local_db/local_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:collection/collection.dart';

Future<Database> initializeDatabase(String dbPath) async {
  return await openDatabase(
    dbPath,
    readOnly: false,
  );
}

class DatabaseHandler {
  final String dbPath;
  late Database database;
  DatabaseHandler._({
    required this.dbPath,
  });

  static Future<DatabaseHandler> create(String dbPath) async {
    final handler = DatabaseHandler._(dbPath: dbPath);
    handler.database = await initializeDatabase(dbPath);
    return handler;
  }

  Future<void> destroy() async {
    await database.close();
    await File(dbPath).delete();
  }

  Future<String?> getDbVersion() async {
    return await _GetMetadata('db_version');
  }

  Future<void> setDbVersion(String version) async {
    await _SetMetadata('db_version', version);
  }

  Future<void> _SetMetadata(String name, String value) async {
    await database.insert(
      'metadata',
      {
        'name': name,
        'value': value,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> _GetMetadata(String name) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'metadata',
      columns: ['value'],
      where: 'name = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return maps.first['value'];
    }

    return null;
  }

  Future<ClassifierSpecies?> getSpecies(String species) async {
    final List<Map<String, dynamic>> maps = await database.query(
        'classifier_species',
        where: 'species = ?',
        whereArgs: [species]);

    if (maps.isNotEmpty) {
      return ClassifierSpecies.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<ClassifierSpecies?> getSpeciesByKey(int specieskey) async {
    final List<Map<String, dynamic>> maps = await database.query(
        'classifier_species',
        where: 'specieskey = ?',
        whereArgs: [specieskey]);

    if (maps.isNotEmpty) {
      return ClassifierSpecies.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<ClassifierSpecies>> getSpeciesByGenus(String genus) async {
    final List<Map<String, dynamic>> maps = await database
        .query('classifier_species', where: 'genus = ?', whereArgs: [genus]);

    return maps.map((e) => ClassifierSpecies.fromMap(e)).toList();
  }

  Future<List<ClassifierCommonName>> getCommonNames(int speciesKey) async {
    final List<Map<String, dynamic>> maps = await database.query(
        'classifier_names',
        where: 'specieskey = ?',
        whereArgs: [speciesKey]);

    return maps.map((e) => ClassifierCommonName.fromMap(e)).toList();
  }

  Future<List<ClassifierSpeciesImages>> getSpeciesImages(int speciesKey) async {
    final List<Map<String, dynamic>> maps = await database.query(
        'classifier_species_images',
        where: 'specieskey = ?',
        whereArgs: [speciesKey]);

    return maps.map((e) => ClassifierSpeciesImages.fromMap(e)).toList();
  }

  Future<ClassifierSpeciesImages?> getSpeciesImage(int speciesKey) async {
    final List<Map<String, dynamic>> maps = await database.query(
        'classifier_species_images',
        where: 'specieskey = ?',
        whereArgs: [speciesKey],
        limit: 1);

    return maps.map((e) => ClassifierSpeciesImages.fromMap(e)).firstOrNull;
  }

  Future<List<ClassifierSpeciesProp>> getSpeciesProps(int speciesKey) async {
    final List<Map<String, dynamic>> maps = await database.query(
        'classifier_species_props',
        where: 'specieskey = ?',
        whereArgs: [speciesKey]);

    return maps.map((e) => ClassifierSpeciesProp.fromMap(e)).toList();
  }

  Future<List<ClassifierSpeciesStat>> getSpeciesStats(int specieskey) async {
    final List<Map<String, dynamic>> maps = await database.query(
        'classifier_species_stats',
        where: 'specieskey = ? AND value != "" AND VALUE IS NOT NULL',
        whereArgs: [specieskey]);

    return maps.map((e) => ClassifierSpeciesStat.fromMap(e)).toList();
  }

  Future<List<ClassifierSimilarSpecies>> getSimilarSpecies(
      int specieskey) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'similar_species',
      where: 'specieskey = ?',
      whereArgs: [specieskey],
    );

    return maps.map((e) => ClassifierSimilarSpecies.fromMap(e)).toList();
  }
}
