import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:fungid_flutter/presentation/pages/observation_list.dart';
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties: DioProperties(
      pubName: 'fungid_api',
      pubAuthor: 'Michael Weishuhn',
    ),
    inputSpecFile: 'fungid-openapi.json',
    generatorName: Generator.dio,
    alwaysRun: true,
    outputDirectory: 'packages/fungid_api')
class FungIDApp extends StatelessWidget {
  const FungIDApp({
    super.key,
    required this.observationsRepsoitory,
    required this.locationRepository,
  });

  final UserObservationsRepository observationsRepsoitory;
  final LocationRepository locationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider.value(
        value: observationsRepsoitory,
      ),
      RepositoryProvider.value(
        value: locationRepository,
      ),
    ], child: const AppView());
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FungID',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ObservationListPage(),
    );
  }
}
