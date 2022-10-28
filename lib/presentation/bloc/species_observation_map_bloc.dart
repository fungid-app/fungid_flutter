import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';
import 'package:geolocator/geolocator.dart';

part 'species_observation_map_event.dart';
part 'species_observation_map_state.dart';

class SpeciesObservationMapBloc
    extends Bloc<SpeciesObservationMapEvent, SpeciesObservationMapState> {
  SpeciesObservationMapBloc({
    required this.locationRepository,
    required String species,
  }) : super(
          SpeciesObservationMapInitial(
            species: species,
          ),
        ) {
    on<SpeciesObservationMapLoadEvent>(_loadSpeciesObservationMap);
  }

  final LocationRepository locationRepository;

  Future<void> _loadSpeciesObservationMap(
    SpeciesObservationMapLoadEvent event,
    Emitter<SpeciesObservationMapState> emit,
  ) async {
    emit(SpeciesObservationMapLoading(
      species: state.species,
    ));

    try {
      await locationRepository.checkPermissions();
    } catch (e) {
      log("Location permission error: $e");
      emit(
        SpeciesObservationMapError(
            species: state.species,
            message: "Location permissions not granted"),
      );
      return;
    }

    try {
      emit(SpeciesObservationMapLoaded(
        species: state.species,
        mapPosition: await locationRepository.determinePosition(),
      ));
    } catch (e) {
      emit(SpeciesObservationMapError(
        species: state.species,
        message: e.toString(),
      ));

      rethrow;
    }
  }
}
