import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/app/app.dart';
import 'package:fungid_flutter/repositories/camera_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:fungid_flutter/monitoring/bloc_monitor.dart';

void bootstrap({
  required UserObservationsSharedPrefProvider observationsProvider,
  required CameraProvider cameraProvider,
}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final observationsRepository =
      UserObservationsRepository(observationsProvider);

  final cameraRepository = CameraRepository(cameraProvider);

  runZonedGuarded(
    () async {
      BlocOverrides.runZoned(
        () => runApp(
          FungIDApp(
            cameraRepository: cameraRepository,
            observationsRepsoitory: observationsRepository,
          ),
        ),
        blocObserver: BlocMonitor(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
