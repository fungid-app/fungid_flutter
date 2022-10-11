import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isOnline() {
  return Connectivity().checkConnectivity().then((value) {
    return value != ConnectivityResult.none;
  });
}
