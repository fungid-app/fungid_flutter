import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/repositories/predictions_repository.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:fungid_flutter/utils/internet.dart';

part 'view_prediction_event.dart';
part 'view_prediction_state.dart';

class ViewPredictionBloc
    extends Bloc<ViewPredictionEvent, ViewPredictionState> {
  ViewPredictionBloc({
    required String observationID,
    required this.observationRepository,
    required this.predictionsRepository,
    required this.speciesRepository,
  }) : super(ViewPredictionState(
          observationID: observationID,
          status: ViewPredictionStatus.initial,
        )) {
    on<ViewPredictionRefreshPredctions>(_onRefreshPredictions);
    on<ViewPredictionGetPredctions>(_onGetPredictions);
    on<ViewPredictionSubscriptionRequested>(_onSubscriptionRequested);
  }

  final UserObservationsRepository observationRepository;
  final PredictionsRepository predictionsRepository;
  final SpeciesRepository speciesRepository;

  Future<void> _onSubscriptionRequested(
    ViewPredictionSubscriptionRequested event,
    Emitter<ViewPredictionState> emit,
  ) async {
    emit(state.copyWith(status: () => ViewPredictionStatus.loading));

    await emit.forEach<List<UserObservation>>(
      observationRepository.getAllObservations(),
      onData: (obs) {
        var idx = obs.indexWhere((o) => o.id == state.observationID);
        if (idx == -1) {
          return state.copyWith(
            status: () => ViewPredictionStatus.deleted,
          );
        } else {
          return state.copyWith(
              status: () => ViewPredictionStatus.success,
              observation: () {
                return obs[idx];
              });
        }
      },
      onError: (_, __) => state.copyWith(
        status: () => ViewPredictionStatus.failure,
      ),
    );
  }

  Future<void> _onRefreshPredictions(
    ViewPredictionRefreshPredctions event,
    Emitter<ViewPredictionState> emit,
  ) async {
    a() async => predictionsRepository.getNewOnlinePredictions(
          state.observation!,
          // null,
        );

    // if (!await isOnline()) {
    //   a = () async => predictionsRepository.getNewOfflinePredictions(
    //         state.observation!,
    //         null,
    //       );
    // }

    await _loadPredictions(a, emit);
  }

  Future<void> _onGetPredictions(
    ViewPredictionGetPredctions event,
    Emitter<ViewPredictionState> emit,
  ) async {
    a() async => predictionsRepository.getOnlinePredictions(
          state.observation!,
          // null,
        );

    // if (!await isOnline()) {
    //   a = () async => predictionsRepository.getOfflinePredictions(
    //         state.observation!,
    //         null,
    //       );
    // }

    await _loadPredictions(a, emit);
  }

  Future<void> _loadPredictions(
    Future<Predictions> Function() loadFunc,
    Emitter<ViewPredictionState> emit,
  ) async {
    emit(state.copyWith(status: () => ViewPredictionStatus.predictionsLoading));

    try {
      final preds = await loadFunc();

      final speciesMap = await speciesRepository.getImageMap(
        species: preds.predictions.map((e) => e.species).toList(),
      );

      emit(
        state.copyWith(
          status: () => ViewPredictionStatus.success,
          predictions: () => preds,
          imageMap: () => speciesMap,
          isCurrentModelVersion: () =>
              predictionsRepository.isCurrentVersion(preds),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: () => ViewPredictionStatus.predictionsFailed,
        errorMessage: () => e.toString(),
      ));
      log(e.toString());
      rethrow;
    }
  }
}
