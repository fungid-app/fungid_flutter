import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/domain/predictions.dart';

part 'local_predictions_view_state.dart';

class LocalPredictionsViewCubit extends Cubit<LocalPredictionsViewState> {
  LocalPredictionsViewCubit({
    required List<LocalPrediction> predictions,
    required bool showOnlyLocal,
  }) : super(
          LocalPredictionsViewState(
            predictions: predictions,
            showOnlyLocal: showOnlyLocal,
          ),
        );

  void toggleShowOnlyLocal() {
    emit(state.copyWith(showOnlyLocal: !state.showOnlyLocal));
  }
}
