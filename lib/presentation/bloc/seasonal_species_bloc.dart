import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';
import 'package:fungid_flutter/repositories/predictions_repository.dart';

part 'seasonal_species_event.dart';
part 'seasonal_species_state.dart';

class SeasonalSpeciesBloc
    extends Bloc<SeasonalSpeciesEvent, SeasonalSpeciesState> {
  SeasonalSpeciesBloc({
    required this.predictionsRepository,
    required this.locationRepository,
  }) : super(SeasonalSpeciesInitial()) {
    on<SeasonalSpeciesLoad>(_loadSeasonalSpecies);
  }

  final PredictionsRepository predictionsRepository;
  final LocationRepository locationRepository;

  Future<void> _loadSeasonalSpecies(
    SeasonalSpeciesLoad event,
    Emitter<SeasonalSpeciesState> emit,
  ) async {
    emit(SeasonalSpeciesLoading(
      date: event.date,
    ));

    try {
      await locationRepository.checkPermissions();
    } catch (e) {
      log("Location permission error: $e");
      emit(const SeasonalSpeciesError(
          message: "Location permissions not granted"));
      return;
    }

    try {
      var location = await locationRepository.determinePosition();
      final predictions = await predictionsRepository.getSeasonalSpecies(
        date: event.date,
        lat: location.lat,
        lon: location.lng,
      );

      emit(SeasonalSpeciesLoaded(
        predictions: predictions,
      ));
    } catch (e) {
      emit(SeasonalSpeciesError(message: e.toString()));

      rethrow;
    }
  }
}
