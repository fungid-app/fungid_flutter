import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:fungid_api/fungid_api.dart';
import 'package:fungid_flutter/bootstrap.dart';
import 'package:fungid_flutter/providers/fungid_api_provider.dart';
import 'package:fungid_flutter/providers/user_observation_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        receiveTimeout: 30000,
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

  // observationsApi.clear();
  bootstrap(
    observationsProvider: observationsApi,
    fungidApiProvider: fungidApiProvider,
  );
}
