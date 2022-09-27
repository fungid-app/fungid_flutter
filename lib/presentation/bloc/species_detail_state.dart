part of 'species_detail_bloc.dart';

abstract class SpeciesDetailState extends Equatable {}

class SpeciesDetailInitial extends SpeciesDetailState {
  @override
  List<Object> get props => [];
}

class SpeciesDetailInitializing extends SpeciesDetailState {
  final String speciesName;
  final UserObservation? observation;

  SpeciesDetailInitializing({
    required this.speciesName,
    this.observation,
  }) : super();

  @override
  List<Object> get props => [
        speciesName,
        observation ?? "",
      ];
}

class SpeciesDetailReady extends SpeciesDetailState {
  final Species species;
  final UserObservation? observation;

  SpeciesDetailReady({
    required this.species,
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
