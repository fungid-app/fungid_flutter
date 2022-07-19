import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' as foundation;

/// [BlocObserver] for the application which
/// observes all state changes.
class BlocMonitor extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    foundation.debugPrint('${bloc.runtimeType} $change');
  }
}
