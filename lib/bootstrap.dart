import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/app/app.dart';
import 'package:fungid_flutter/providers/offline_predictions_provider.dart';
import 'package:fungid_flutter/providers/online_predictions_provider.dart';
import 'package:fungid_flutter/providers/saved_predictions_provider.dart';
import 'package:fungid_flutter/providers/local_database_provider.dart';
import 'package:fungid_flutter/providers/user_observation_image_provider.dart';
import 'package:fungid_flutter/providers/user_observation_provider.dart';
import 'package:fungid_flutter/providers/wikipedia_article_provider.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';
import 'package:fungid_flutter/repositories/predictions_repository.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:fungid_flutter/monitoring/bloc_monitor.dart';

void bootstrap({
  required SharedPrefsStorageProvider observationsProvider,
  required UserObservationImageFileSystemProvider imageProvider,
  required OnlinePredictionsProvider onlinePredictionsProvider,
  required OfflinePredictionsProvider offlinePredictionsProvider,
  required SavedPredictionsSharedPrefProvider savedPredictionsProvider,
  required LocalDatabaseProvider localDatabaseProvider,
  required WikipediaArticleProvider wikipediaArticleProvider,
}) {
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  final observationsRepository = UserObservationsRepository(
    observationsProvider: observationsProvider,
    imageProvider: imageProvider,
  );

  final predictionsRepository = PredictionsRepository(
    imageStorageDirectory: imageProvider.storageDirectory,
    savedPredictionsProvider: savedPredictionsProvider,
    onlinePredictionsProvider: onlinePredictionsProvider,
    offlinePredictionsProvider: offlinePredictionsProvider,
    localDatabaseProvider: localDatabaseProvider,
  );
  final locationRepository = LocationRepository();
  Bloc.observer = BlocMonitor();

  final speciesRepository = SpeciesRepository(
    speciesProvider: localDatabaseProvider,
    wikipediaProvider: wikipediaArticleProvider,
  );

  runApp(
    FungIDApp(
      observationsRepsoitory: observationsRepository,
      locationRepository: locationRepository,
      predictionsRepository: predictionsRepository,
      speciesRepository: speciesRepository,
    ),
  );
}
