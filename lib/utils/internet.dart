import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isOnline() {
  return Connectivity().checkConnectivity().then((values) {
    return !values.contains(ConnectivityResult.none);
  });
}
