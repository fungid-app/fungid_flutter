import 'package:flutter/material.dart';
import 'package:fungid_flutter/bootstrap.dart';
import 'package:fungid_flutter/providers/user_observation_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final observationsApi = UserObservationsSharedPrefProvider(
    prefs: await SharedPreferences.getInstance(),
  );

  // observationsApi.clear();
  bootstrap(
    observationsProvider: observationsApi,
  );
}
