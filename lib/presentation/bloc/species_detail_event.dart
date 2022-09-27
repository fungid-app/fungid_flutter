part of 'species_detail_bloc.dart';

abstract class SpeciesDetailEvent extends Equatable {
  const SpeciesDetailEvent();

  @override
  List<Object> get props => [];
}

class SpeciesDetailInitalizeEvent extends SpeciesDetailEvent {
  final String speciesName;
  final UserObservation? observation;

  const SpeciesDetailInitalizeEvent({
    required this.speciesName,
    this.observation,
  });

  @override
  List<Object> get props => [
        speciesName,
      ];
}
