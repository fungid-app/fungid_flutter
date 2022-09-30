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

  Future<String?> getImageVersion() async {
    return await _GetMetadata('image_version');
  }

  Future<void> _setDbVersion(String version) async {
    await _SetMetadata('db_version', version);
  }

  Future<void> _setImageVersion(String version) async {
    await _SetMetadata('image_version', version);
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

  Future<void> LoadDB(String createScript, String dbVersion) async {
    await _runScript(createScript);
    await _setDbVersion(dbVersion);
  }

  Future<void> LoadImages(String imageInsertScript, String imageVersion) async {
    await _runScript(imageInsertScript);
    await _setImageVersion(imageVersion);
  }

  Future<void> _runScript(String script) async {
    var db = await database;

    var batch = db.batch();

    for (var cmd in script.split(';')) {
      if (cmd.trim() != '') {
        batch.execute(cmd.trim());
      }
    }

    await batch.commit();
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

  Future<List<ClassifierEluValues>> getEluValues(int eluID) async {
    final db = await this.database;

    final List<Map<String, dynamic>> maps = await db
        .query('classifier_elu_values', where: 'eluid = ?', whereArgs: [eluID]);

    return maps.map((e) => ClassifierEluValues.fromMap(e)).toList();
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

  Future<List<ClassifierSpeciesStat>> getSpeciesStats(String species) async {
    final db = await this.database;

    final List<Map<String, dynamic>> maps = await db.query(
        'classifier_species_stats',
        where: 'species = ? AND value != "" AND VALUE IS NOT NULL',
        whereArgs: [species]);

    return maps.map((e) => ClassifierSpeciesStat.fromMap(e)).toList();
  }
}
