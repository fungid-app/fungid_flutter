import 'dart:async';
import 'dart:developer';

import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_map_tile_caching/fmtc_advanced.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:fungid_api/fungid_api.dart';
import 'package:fungid_flutter/bootstrap.dart';
import 'package:fungid_flutter/providers/app_settings_provider.dart';
import 'package:fungid_flutter/providers/local_database_provider.dart';
import 'package:fungid_flutter/providers/offline_predictions_provider.dart';
import 'package:fungid_flutter/providers/online_predictions_provider.dart';
import 'package:fungid_flutter/providers/saved_predictions_provider.dart';
import 'package:fungid_flutter/providers/user_observation_image_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fungid_flutter/providers/user_observation_provider.dart';
import 'package:fungid_flutter/providers/wikipedia_article_provider.dart';
import 'package:fungid_flutter/utils/filesystem.dart';
import 'package:local_db/local_db.dart';
import 'package:path/path.dart' as path;
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as io;

const String _bundleDbVersion = '0.4.6';
const String _bundleWikiVersion = '0.4.1';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await setupFirebase();
      FlutterMapTileCaching.initialise(await RootDirectory.normalCache);

      await FlutterDownloader.initialize(
        debug:
            true, // optional: set to false to disable printing logs to console (default: true)
      );

      var responses = await Future.wait<dynamic>([
        getOnlinePredictions(getFungidApi()),
        getLocalDb(),
        UserObservationImageFileSystemProvider.create(),
        setupWikipedia(),
        SharedPreferences.getInstance()
      ]);

      bootstrap(
        onlinePredictionsProvider: responses[0],
        offlinePredictionsProvider: await getOfflinePredictions(
          responses[1],
        ),
        localDatabaseProvider: LocalDatabaseProvider(
          responses[1],
        ),
        imageProvider: responses[2],
        wikipediaArticleProvider: responses[3],
        savedPredictionsProvider: SavedPredictionsSharedPrefProvider(
          prefs: responses[4],
        ),
        observationsProvider: SharedPrefsStorageProvider(
          prefs: responses[4],
        ),
        appSettingsProvider: AppSettingsSharedPrefProvider(
          prefs: responses[4],
        ),
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

FungidApi getFungidApi() {
  return FungidApi(
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
  );
}

Future<DatabaseHandler> getLocalDb() async {
  // Setup local DB
  // Construct a file path to copy database to

  // Setup local DB
  // Construct a file path to copy database to
  String localDbPath = await getLocalFilePath("app.sqlite3");

  var loadLocalDb = io.FileSystemEntity.typeSync(localDbPath) ==
      io.FileSystemEntityType.notFound;

  if (!loadLocalDb) {
    var db = await DatabaseHandler.create(localDbPath);

    try {
      if (_bundleDbVersion != await db.getDbVersion()) {
        log('Database version mismatch, reloading');
        loadLocalDb = true;
        await db.destroy();
      } else {
        log('Database version match, not reloading');
      }
    } catch (e, stacktrace) {
      log('Error loading database version, reloading',
          error: e, stackTrace: stacktrace);
      loadLocalDb = true;
      await db.destroy();

      await FirebaseCrashlytics.instance.recordError(
        e,
        stacktrace,
        reason: 'Error loading db version',
      );
    }
  }

  // Only copy if the database doesn't exist
  if (loadLocalDb) {
    // Load database from asset and copy
    log("Loading database from assets and copying to $localDbPath");

    ByteData data =
        await rootBundle.load(path.join('assets', 'app.sqlite3.bz2'));

    List<int> compressed =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    log('Database ${compressed.length} bytes compressed');
    var decompressed = BZip2Decoder().decodeBytes(compressed);
    log('Database ${decompressed.length} bytes decompressed');

    // Save copied asset to documents
    await io.File(localDbPath).writeAsBytes(decompressed);

    log('Database saved to $localDbPath');

    var localDb = await DatabaseHandler.create(localDbPath);

    await localDb.setDbVersion(_bundleDbVersion);
  }

  var localDb = await DatabaseHandler.create(localDbPath);

  return localDb;
}

Future<OfflinePredictionsProvider> getOfflinePredictions(
  DatabaseHandler db,
) async {
  return await OfflinePredictionsProvider.create(
    dataPath: 'models',
    db: db,
  );
}

Future<WikipediaArticleProvider> setupWikipedia() async {
  String localWikiPath = await getLocalFilePath('wikipedia');
  String versionFilePath = "version.txt";

  log(versionFilePath);

  io.File versionFile = io.File("$localWikiPath/$versionFilePath");

  if (await versionFile.exists() &&
      _bundleWikiVersion == await versionFile.readAsString()) {
    log('Wikipedia version match, not reloading');
  } else {
    log('Wikipedia version mismatch, bundle $_bundleWikiVersion != local');

    ByteData data =
        await rootBundle.load(path.join('assets', 'wikipedia.tar.bz2'));

    List<int> compressed =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    List<int> decompressed = BZip2Decoder().decodeBytes(compressed);

    var tar = TarDecoder().decodeBytes(decompressed);

    extractArchiveToDisk(tar, await getLocalFilePath('wikipedia'));

    await versionFile.writeAsString(_bundleWikiVersion);
  }

  return WikipediaArticleProvider(
    wikiPath: localWikiPath,
  );
}

Future<OnlinePredictionsProvider> getOnlinePredictions(FungidApi api) async {
  final onlinePredictionsProvider = await OnlinePredictionsProvider.create(api);

  return onlinePredictionsProvider;
}
