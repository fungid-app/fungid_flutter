part of 'observation_map_bloc.dart';

abstract class ObservationMapState extends Equatable {
  const ObservationMapState();
}

class ObservationMapInitial extends ObservationMapState {
  const ObservationMapInitial();

  @override
  List<Object> get props => [];
}

class ObservationMapLoading extends ObservationMapState {
  const ObservationMapLoading();

  @override
  List<Object> get props => [];
}

class ObservationMapLoaded extends ObservationMapState {
  final Position mapPosition;
  final String mapTileUrl;
  final bool showMarker;

  const ObservationMapLoaded({
    required this.mapPosition,
    required this.mapTileUrl,
    required this.showMarker,
  });

  @override
  List<Object> get props => [
        mapPosition,
        mapTileUrl,
        showMarker,
      ];
}

class ObservationMapError extends ObservationMapState {
  final String message;

  const ObservationMapError({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}
