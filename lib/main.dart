import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
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

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Pass all uncaught errors from the framework to Crashlytics.
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      final observationsApi = UserObservationsSharedPrefProvider(
        prefs: await SharedPreferences.getInstance(),
      );

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

      // Setup local DB
      // Construct a file path to copy database to
      io.Directory documentsDirectory =
          await getApplicationDocumentsDirectory();
      String p = path.join(documentsDirectory.path, "app.sqlite3");

      // Only copy if the database doesn't exist
      if (io.FileSystemEntity.typeSync(p) == io.FileSystemEntityType.notFound) {
        // Load database from asset and copy
        ByteData data =
            await rootBundle.load(path.join('assets', 'db/app.sqlite3'));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        // Save copied asset to documents
        await io.File(p).writeAsBytes(bytes);
      }

      var db = DatabaseHandler(
        dbPath: p,
      );

      final SpeciesLocalDatabaseProvider speciesProvider =
          SpeciesLocalDatabaseProvider(db);

      final predictionsProvider = PredictionsSharedPrefProvider(
        prefs: await SharedPreferences.getInstance(),
      );
      // observationsApi.clear();

      bootstrap(
        observationsProvider: observationsApi,
        fungidApiProvider: fungidApiProvider,
        imageProvider: UserObservationImageFileSystemProvider(),
        predictionsProvider: predictionsProvider,
        speciesProvider: speciesProvider,
      );
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}
