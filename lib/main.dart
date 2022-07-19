import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fungid_flutter/bootstrap.dart';
import 'package:fungid_flutter/repositories/camera_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameraProvider = CameraProvider(
    cameras: await availableCameras(),
  );

  final observationsApi = UserObservationsSharedPrefProvider(
    prefs: await SharedPreferences.getInstance(),
  );

  bootstrap(
    observationsProvider: observationsApi,
    cameraProvider: cameraProvider,
  );
}
