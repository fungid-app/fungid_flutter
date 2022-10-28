part of 'species_observation_map_bloc.dart';

abstract class SpeciesObservationMapState extends Equatable {
  final String species;
  const SpeciesObservationMapState({
    required this.species,
  });

  @override
  List<Object> get props => [
        species,
      ];
}

class SpeciesObservationMapInitial extends SpeciesObservationMapState {
  const SpeciesObservationMapInitial({
    required String species,
  }) : super(species: species);
}

class SpeciesObservationMapLoading extends SpeciesObservationMapState {
  const SpeciesObservationMapLoading({
    required String species,
  }) : super(species: species);

  @override
  List<Object> get props => [
        species,
      ];
}

class SpeciesObservationMapLoaded extends SpeciesObservationMapState {
  final Position mapPosition;

  const SpeciesObservationMapLoaded({
    required this.mapPosition,
    required String species,
  }) : super(species: species);

  @override
  List<Object> get props => [
        species,
        mapPosition,
      ];
}

class SpeciesObservationMapError extends SpeciesObservationMapState {
  final String message;

  const SpeciesObservationMapError({
    required this.message,
    required String species,
  }) : super(species: species);

  @override
  List<Object> get props => [
        message,
        species,
      ];
}
