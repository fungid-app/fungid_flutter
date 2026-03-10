import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fungid_flutter/domain/internet.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({
    required this.connectivity,
  }) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  Future<StreamSubscription<List<ConnectivityResult>>>
      monitorInternetConnection() async {
    var results = await connectivity.checkConnectivity();
    emitResults(results);

    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResults) {
      emitResults(connectivityResults);
    });
  }

  void emitResults(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi)) {
      emitInternetConnected(ConnectionType.wifi);
    } else if (results.contains(ConnectivityResult.mobile)) {
      emitInternetConnected(ConnectionType.mobile);
    } else if (results.contains(ConnectivityResult.none)) {
      emitInternetDisconnected();
    }
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
