import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fungid_flutter/screens/home_screen.dart';
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties:
        DioProperties(pubName: 'fungid_api', pubAuthor: 'Michael Weishuhn'),
    inputSpecFile: 'openapi-spec.json',
    generatorName: Generator.dio,
    alwaysRun: true,
    outputDirectory: 'packages/fungid_api')
class FungIDApp extends StatelessWidget {
  const FungIDApp({
    super.key,
    required this.cameras,
  });

  final List<CameraDescription> cameras;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FungID',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(
        cameras: cameras,
      ),
    );
  }
}
