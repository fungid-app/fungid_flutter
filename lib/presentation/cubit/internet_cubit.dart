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

  Future<StreamSubscription<ConnectivityResult>>
      monitorInternetConnection() async {
    var result = await connectivity.checkConnectivity();
    emitResult(result);

    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      emitResult(connectivityResult);
    });
  }

  void emitResult(ConnectivityResult result) {
    if (result == ConnectivityResult.wifi) {
      emitInternetConnected(ConnectionType.wifi);
    } else if (result == ConnectivityResult.mobile) {
      emitInternetConnected(ConnectionType.mobile);
    } else if (result == ConnectivityResult.none) {
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
