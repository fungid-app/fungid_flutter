import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/domain.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';

part 'view_observation_event.dart';
part 'view_observation_state.dart';

class ViewObservationBloc
    extends Bloc<ViewObservationEvent, ViewObservationState> {
  ViewObservationBloc({
    required UserObservation observation,
    required this.observationRepository,
  }) : super(ViewObservationState(
          observation: observation,
          status: ViewObservationStatus.initial,
        )) {
    on<ViewObservationGetPredctions>(_onGetPredictions);
    on<ViewObservationSave>(_onSave);
  }

  final UserObservationsRepository observationRepository;

  Future<void> _onGetPredictions(
    ViewObservationGetPredctions event,
    Emitter<ViewObservationState> emit,
  ) async {
    emit(state.copyWith(status: ViewObservationStatus.loading));

    // final predictions = await observationRepository.getPredictions(
    //   observation: state.observation,
    // );

    const predictions = null;

    emit(state.copyWith(
      status: ViewObservationStatus.success,
      observation: state.observation.copyWith(
        predictions: predictions,
      ),
    ));
  }

  Future<void> _onSave(
    ViewObservationSave event,
    Emitter<ViewObservationState> emit,
  ) async {
    emit(state.copyWith(status: ViewObservationStatus.loading));

    await observationRepository.saveObservation(state.observation);

    emit(state.copyWith(status: ViewObservationStatus.success));
  }
}
