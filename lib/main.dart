import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fungid_flutter/app/app.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(FungIDApp(cameras: _cameras));
}
