part of 'observation_map_bloc.dart';

abstract class ObservationMapEvent extends Equatable {
  const ObservationMapEvent();

  @override
  List<Object> get props => [];
}

class ObservationMapLoadSpeciesEvent extends ObservationMapEvent {
  final String species;
  const ObservationMapLoadSpeciesEvent({
    required this.species,
  });

  @override
  List<Object> get props => [species];
}

class ObservationMapLoadSeasonalEvent extends ObservationMapEvent {
  final int month;
  final int day;
  const ObservationMapLoadSeasonalEvent({
    required this.month,
    required this.day,
  });

  @override
  List<Object> get props => [month, day];
}
