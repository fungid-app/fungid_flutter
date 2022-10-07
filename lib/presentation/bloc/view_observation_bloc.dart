import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/repositories/predictions_repository.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';

part 'view_observation_event.dart';
part 'view_observation_state.dart';

class ViewObservationBloc
    extends Bloc<ViewObservationEvent, ViewObservationState> {
  ViewObservationBloc({
    required String id,
    required this.observationRepository,
    required this.predictionsRepository,
    required this.speciesRepository,
  }) : super(ViewObservationState(
          id: id,
          status: ViewObservationStatus.initial,
        )) {
    on<ViewObservationRefreshPredctions>(_onRefreshPredictions);
    on<ViewObservationGetPredctions>(_onGetPredictions);
    on<ViewObservationSave>(_onSave);
    on<ViewObservationDelete>(_onDelete);
    on<ViewObservationSubscriptionRequested>(_onSubscriptionRequested);
    on<ViewObservationEdit>(_onEdit);
  }

  final UserObservationsRepository observationRepository;
  final PredictionsRepository predictionsRepository;
  final SpeciesRepository speciesRepository;

  Future<void> _onSubscriptionRequested(
    ViewObservationSubscriptionRequested event,
    Emitter<ViewObservationState> emit,
  ) async {
    emit(state.copyWith(status: () => ViewObservationStatus.loading));

    await emit.forEach<List<UserObservation>>(
      observationRepository.getAllObservations(),
      onData: (obs) {
        var idx = obs.indexWhere((o) => o.id == state.id);
        if (idx == -1) {
          return state.copyWith(
            status: () => ViewObservationStatus.deleted,
          );
        } else {
          return state.copyWith(
              status: () => ViewObservationStatus.success,
              observation: () {
                return obs[idx];
              });
        }
      },
      onError: (_, __) => state.copyWith(
        status: () => ViewObservationStatus.failure,
      ),
    );
  }

  Future<void> _onEdit(
    ViewObservationEdit event,
    Emitter<ViewObservationState> emit,
  ) async {
    emit(state.copyWith(status: () => ViewObservationStatus.editing));
  }

  Future<void> _onRefreshPredictions(
    ViewObservationRefreshPredctions event,
    Emitter<ViewObservationState> emit,
  ) async {
    await _loadPredictions(
        () async => await predictionsRepository.getNewOnlinePredictions(
              state.observation!,
              // null,
            ),
        emit);
  }

  Future<void> _onGetPredictions(
    ViewObservationGetPredctions event,
    Emitter<ViewObservationState> emit,
  ) async {
    await _loadPredictions(
        () async => await predictionsRepository.getNewOnlinePredictions(
              state.observation!,
              // null,
            ),
        emit);
  }

  Future<void> _loadPredictions(
    Future<Predictions> Function() loadFunc,
    Emitter<ViewObservationState> emit,
  ) async {
    emit(
        state.copyWith(status: () => ViewObservationStatus.predictionsLoading));

    try {
      final preds = await loadFunc();

      final speciesMap = await speciesRepository.getImageMap(
        species: preds.predictions.map((e) => e.species).toList(),
      );

      emit(
        state.copyWith(
          status: () => ViewObservationStatus.success,
          predictions: () => preds,
          imageMap: () => speciesMap,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: () => ViewObservationStatus.predictionsFailed,
        errorMessage: () => e.toString(),
      ));
      log(e.toString());
      rethrow;
    }
  }

  Future<void> _onDelete(
    ViewObservationDelete event,
    Emitter<ViewObservationState> emit,
  ) async {
    await observationRepository.deleteObservation(state.id);
    emit(state.copyWith(status: () => ViewObservationStatus.deleted));
  }

  Future<void> _onSave(
    ViewObservationSave event,
    Emitter<ViewObservationState> emit,
  ) async {
    await observationRepository.saveObservation(state.observation!);

    emit(state.copyWith(status: () => ViewObservationStatus.success));
  }
}
