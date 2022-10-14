part of 'species_detail_bloc.dart';

abstract class SpeciesDetailState extends Equatable {}

class SpeciesDetailInitial extends SpeciesDetailState {
  @override
  List<Object> get props => [];
}

class SpeciesDetailInitializing extends SpeciesDetailState {
  final String? speciesName;
  final int? speciesKey;
  final UserObservation? observation;

  SpeciesDetailInitializing({
    this.speciesName,
    this.speciesKey,
    this.observation,
  }) : super();

  @override
  List<Object> get props => [
        speciesName ?? "",
        speciesKey ?? 0,
        observation ?? "",
      ];
}

class SpeciesDetailReady extends SpeciesDetailState {
  final Species species;
  final List<BasicPrediction> similarSpecies;
  final UserObservation? observation;

  SpeciesDetailReady({
    required this.species,
    required this.similarSpecies,
    this.observation,
  }) : super();

  @override
  List<Object> get props => [
        species,
        observation ?? "",
      ];
}

class SpeciesDetailFailure extends SpeciesDetailState {
  final String message;

  SpeciesDetailFailure({
    required this.message,
  }) : super();

  @override
  List<Object> get props => [message];
}
