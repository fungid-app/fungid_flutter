import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:fungid_api/fungid_api.dart';
import 'package:fungid_flutter/bootstrap.dart';
import 'package:fungid_flutter/providers/offline_predictions_provider.dart';
import 'package:fungid_flutter/providers/online_predictions_provider.dart';
import 'package:fungid_flutter/providers/saved_predictions_provider.dart';
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

const String _dbVersion = '0.4.2';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      var responses = await Future.wait<dynamic>([
        setupFirebase(),
        getObservationsApi(),
        getOnlinePredictions(),
        getOfflinePredictions(),
        getPredictions(),
        getSpeciesDb(),
        UserObservationImageFileSystemProvider.create()
      ]);

      bootstrap(
        observationsProvider: responses[1],
        onlinePredictionsProvider: responses[2],
        offlinePredictionsProvider: responses[3],
        savedPredictionsProvider: responses[4],
        speciesProvider: responses[5],
        imageProvider: responses[6],
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

Future<SavedPredictionsSharedPrefProvider> getPredictions() async {
  final predictionsProvider = SavedPredictionsSharedPrefProvider(
    prefs: await SharedPreferences.getInstance(),
  );
  return predictionsProvider;
}

Future<SpeciesLocalDatabaseProvider> getSpeciesDb() async {
  // Setup local DB
  // Construct a file path to copy database to

  // Setup local DB
  // Construct a file path to copy database to
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
        log('Database version mismatch, reloading');
        loadDb = true;
        db.destroy();
      }
    } catch (e, stacktrace) {
      log('Error loading database version, reloading',
          error: e, stackTrace: stacktrace);
      loadDb = true;
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
    log("Loading database from asset and copying to $p");
    ByteData data =
        await rootBundle.load(path.join('assets', 'db/app.sqlite3'));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    log('Database ${bytes.length} bytes loaded');
    // Save copied asset to documents
    await io.File(p).writeAsBytes(bytes);

    log('Database saved to $p');

    var db = DatabaseHandler(
      dbPath: p,
    );

    await db.setDbVersion(_dbVersion);
  }

  var db = DatabaseHandler(
    dbPath: p,
  );

  return SpeciesLocalDatabaseProvider(db);
}

Future<OfflinePredictionsProvider> getOfflinePredictions() async {
  return await OfflinePredictionsProvider.create(
    'assets/models/mobile-image-model.pt',
    'assets/models/labels.csv',
  );
}

Future<OnlinePredictionsProvider> getOnlinePredictions() async {
  final onlinePredictionsProvider = await OnlinePredictionsProvider.create(
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

  return onlinePredictionsProvider;
}

Future<UserObservationsSharedPrefProvider> getObservationsApi() async {
  final observationsApi = UserObservationsSharedPrefProvider(
    prefs: await SharedPreferences.getInstance(),
  );
  return observationsApi;
}
