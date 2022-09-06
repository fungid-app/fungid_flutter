import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/app/app.dart';
import 'package:fungid_flutter/providers/user_observation_provider.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:fungid_flutter/monitoring/bloc_monitor.dart';

void bootstrap({
  required UserObservationsSharedPrefProvider observationsProvider,
}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final observationsRepository =
      UserObservationsRepository(provider: observationsProvider);
  final locationRepository = LocationRepository();

  runZonedGuarded(
    () async {
      BlocOverrides.runZoned(
        () => runApp(
          FungIDApp(
            observationsRepsoitory: observationsRepository,
            locationRepository: locationRepository,
          ),
        ),
        blocObserver: BlocMonitor(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
