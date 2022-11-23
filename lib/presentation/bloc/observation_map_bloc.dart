import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';
import 'package:geolocator/geolocator.dart';

part 'observation_map_event.dart';
part 'observation_map_state.dart';

String heatmapBaseUrl = 'https://api.fungid.app';
// String heatmapBaseUrl = 'http://192.168.88.25:8080';
String heatmapUrl = '$heatmapBaseUrl/observations/heatmap';
String heatmapUrlEnding = '{z}/{x}/{y}.png';

class ObservationMapBloc
    extends Bloc<ObservationMapEvent, ObservationMapState> {
  ObservationMapBloc({
    required this.locationRepository,
    this.showMarker = true,
  }) : super(
          const ObservationMapInitial(),
        ) {
    on<ObservationMapLoadSpeciesEvent>(_loadSpeciesObservationMap);
    on<ObservationMapLoadSeasonalEvent>(_loadSeasonalObservationMap);
  }

  final bool showMarker;
  final LocationRepository locationRepository;

  Future<void> _loadSpeciesObservationMap(
    ObservationMapLoadSpeciesEvent event,
    Emitter<ObservationMapState> emit,
  ) async {
    String mapTileUrl = "$heatmapUrl/${event.species}/$heatmapUrlEnding";
    await loadMap(mapTileUrl, emit);
  }

  Future<void> _loadSeasonalObservationMap(
    ObservationMapLoadSeasonalEvent event,
    Emitter<ObservationMapState> emit,
  ) async {
    String mapTileUrl =
        "$heatmapUrl/seasonal/${event.month}/${event.day}/$heatmapUrlEnding";

    await loadMap(mapTileUrl, emit);
  }

  Future<void> loadMap(
    String mapTileUrl,
    Emitter<ObservationMapState> emit,
  ) async {
    emit(const ObservationMapLoading());

    try {
      await locationRepository.checkPermissions();
    } catch (e) {
      log("Location permission error: $e");
      emit(
        const ObservationMapError(message: "Location permissions not granted"),
      );
      return;
    }

    try {
      emit(ObservationMapLoaded(
        mapPosition: await locationRepository.determinePosition(),
        mapTileUrl: mapTileUrl,
        showMarker: showMarker,
      ));
    } catch (e) {
      emit(ObservationMapError(
        message: e.toString(),
      ));

      rethrow;
    }
  }
}
