import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:fungid_api/fungid_api.dart';
import 'package:fungid_flutter/bootstrap.dart';
import 'package:fungid_flutter/providers/fungid_api_provider.dart';
import 'package:fungid_flutter/providers/predictions_provider.dart';
import 'package:fungid_flutter/providers/species_local_database_provider.dart';
import 'package:fungid_flutter/providers/user_observation_image_provider.dart';
import 'package:fungid_flutter/providers/user_observation_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:local_db/local_db.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as io;

const String _dbVersion = '0.0.1';
const String _imageVersion = '0.0.1';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await setupFirebase();

      bootstrap(
        observationsProvider: await getObservationsApi(),
        fungidApiProvider: getFungidApi(),
        imageProvider: UserObservationImageFileSystemProvider(),
        predictionsProvider: await getPredictions(),
        speciesProvider: await getSpeciesDb(),
      );
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}

Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
}

Future<PredictionsSharedPrefProvider> getPredictions() async {
  final predictionsProvider = PredictionsSharedPrefProvider(
    prefs: await SharedPreferences.getInstance(),
  );
  return predictionsProvider;
}

Future<SpeciesLocalDatabaseProvider> getSpeciesDb() async {
  // Setup local DB
  // Construct a file path to copy database to
  DatabaseHandler db = await ensureDB();
  await ensureImages(db);

  final SpeciesLocalDatabaseProvider speciesProvider =
      SpeciesLocalDatabaseProvider(db);
  return speciesProvider;
}

Future<void> ensureImages(DatabaseHandler db) async {
  if (_imageVersion != await db.getImageVersion()) {
    String insertScript =
        await rootBundle.loadString(path.join('assets', 'db/images.sql'));

    await db.LoadImages(insertScript, _imageVersion);
  }
}

Future<DatabaseHandler> ensureDB() async {
  io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String p = path.join(documentsDirectory.path, "app.sqlite3");

  var loadDb =
      io.FileSystemEntity.typeSync(p) == io.FileSystemEntityType.notFound;

  if (!loadDb) {
    var db = DatabaseHandler(
      dbPath: p,
    );

    try {
      if (_dbVersion != await db.getDbVersion()) {
        loadDb = true;
        // Delete old DB
        db.destroy();
      }
    } catch (e, stacktrace) {
      loadDb = true;
      // Delete old DB
      db.destroy();

      await FirebaseCrashlytics.instance.recordError(
        e,
        stacktrace,
        reason: 'Error loading db version',
      );
    }
  }

  // Only copy if the database doesn't exist
  if (loadDb) {
    // Load database from asset and copy
    String createScript =
        await rootBundle.loadString(path.join('assets', 'db/create.sql'));

    var db = DatabaseHandler(
      dbPath: p,
    );

    await db.LoadDB(createScript, _dbVersion);
  }

  var db = DatabaseHandler(
    dbPath: p,
  );

  return db;
}

FungidApiProvider getFungidApi() {
  final fungidApiProvider = FungidApiProvider(
    FungidApi(
      dio: Dio(BaseOptions(
        // Production
        baseUrl: 'https://api.fungid.app',
        // Web Site/Desktop/iOS
        // baseUrl: 'http://0.0.0.0:8080',
        // Android Phone Emulator
        // baseUrl: 'https://10.0.2.2:8080',
        // LocalIp
        // baseUrl: 'http://192.168.0.186:8080',
        connectTimeout: 50000,
        receiveTimeout: 60000,
      )),
      interceptors: [
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
        ),
      ],
    ),
  );
  return fungidApiProvider;
}

Future<UserObservationsSharedPrefProvider> getObservationsApi() async {
  final observationsApi = UserObservationsSharedPrefProvider(
    prefs: await SharedPreferences.getInstance(),
  );
  return observationsApi;
}
