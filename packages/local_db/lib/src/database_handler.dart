import 'dart:io';

import 'package:local_db/local_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:collection/collection.dart';

Future<Database> initializeDatabase(String dbPath) async {
  return openDatabase(
    dbPath,
    readOnly: false,
  );
}

class DatabaseHandler {
  final String dbPath;
  DatabaseHandler({
    required this.dbPath,
  }) : this.database = initializeDatabase(dbPath);

  Future<Database> database;

  Future<void> destroy() async {
    final db = await database;
    await db.close();
    await File(dbPath).delete();
  }

  Future<String?> getDbVersion() async {
    return await _GetMetadata('db_version');
  }

  Future<void> setDbVersion(String version) async {
    await _SetMetadata('db_version', version);
  }

  Future<void> _SetMetadata(String name, String value) async {
    var db = await database;
    await db.insert(
      'metadata',
      {
        'name': name,
        'value': value,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> _GetMetadata(String name) async {
    final db = await this.database;

    final List<Map<String, dynamic>> maps = await db.query(
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
    final db = await this.database;

    final List<Map<String, dynamic>> maps = await db.query('classifier_species',
        where: 'species = ?', whereArgs: [species]);

    if (maps.isNotEmpty) {
      return ClassifierSpecies.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<ClassifierSpecies>> getSpeciesByGenus(String genus) async {
    final db = await this.database;

    final List<Map<String, dynamic>> maps = await db
        .query('classifier_species', where: 'genus = ?', whereArgs: [genus]);

    return maps.map((e) => ClassifierSpecies.fromMap(e)).toList();
  }

  Future<List<ClassifierCommonName>> getCommonNames(int speciesKey) async {
    final db = await this.database;

    final List<Map<String, dynamic>> maps = await db.query('classifier_names',
        where: 'specieskey = ?', whereArgs: [speciesKey]);

    return maps.map((e) => ClassifierCommonName.fromMap(e)).toList();
  }

  Future<List<ClassifierSpeciesImages>> getSpeciesImages(int speciesKey) async {
    final db = await this.database;

    final List<Map<String, dynamic>> maps = await db.query(
        'classifier_species_images',
        where: 'specieskey = ?',
        whereArgs: [speciesKey]);

    return maps.map((e) => ClassifierSpeciesImages.fromMap(e)).toList();
  }

  Future<ClassifierSpeciesImages?> getSpeciesImage(int speciesKey) async {
    final db = await this.database;

    final List<Map<String, dynamic>> maps = await db.query(
        'classifier_species_images',
        where: 'specieskey = ?',
        whereArgs: [speciesKey],
        limit: 1);

    return maps.map((e) => ClassifierSpeciesImages.fromMap(e)).firstOrNull;
  }

  Future<List<ClassifierSpeciesProp>> getSpeciesProps(int speciesKey) async {
    final db = await this.database;

    final List<Map<String, dynamic>> maps = await db.query(
        'classifier_species_props',
        where: 'specieskey = ?',
        whereArgs: [speciesKey]);

    return maps.map((e) => ClassifierSpeciesProp.fromMap(e)).toList();
  }

  Future<List<ClassifierSpeciesStat>> getSpeciesStats(int specieskey) async {
    final db = await this.database;

    final List<Map<String, dynamic>> maps = await db.query(
        'classifier_species_stats',
        where: 'specieskey = ? AND value != "" AND VALUE IS NOT NULL',
        whereArgs: [specieskey]);

    return maps.map((e) => ClassifierSpeciesStat.fromMap(e)).toList();
  }
}
