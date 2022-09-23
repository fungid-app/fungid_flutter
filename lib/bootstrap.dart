import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/app/app.dart';
import 'package:fungid_flutter/providers/fungid_api_provider.dart';
import 'package:fungid_flutter/providers/predictions_provider.dart';
import 'package:fungid_flutter/providers/species_local_database_provider.dart';
import 'package:fungid_flutter/providers/user_observation_image_provider.dart';
import 'package:fungid_flutter/providers/user_observation_provider.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';
import 'package:fungid_flutter/repositories/predictions_repository.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:fungid_flutter/monitoring/bloc_monitor.dart';

void bootstrap({
  required UserObservationsSharedPrefProvider observationsProvider,
  required FungidApiProvider fungidApiProvider,
  required UserObservationImageFileSystemProvider imageProvider,
  required PredictionsSharedPrefProvider predictionsProvider,
  required SpeciesLocalDatabaseProvider speciesProvider,
}) {
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  final observationsRepository = UserObservationsRepository(
    observationsProvider: observationsProvider,
    fungidApiProvider: fungidApiProvider,
    imageProvider: imageProvider,
  );

  final predictionsRepository = PredictionsRepository(
    predictionsProvider: predictionsProvider,
    fungidApiProvider: fungidApiProvider,
  );
  final locationRepository = LocationRepository();
  Bloc.observer = BlocMonitor();

  final speciesRepository = SpeciesRepository(
    speciesProvider: speciesProvider,
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
