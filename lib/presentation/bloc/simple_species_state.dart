part of 'simple_species_bloc.dart';

abstract class SimpleSpeciesState extends Equatable {
  const SimpleSpeciesState();

  @override
  List<Object> get props => [];
}

class SimpleSpeciesInitial extends SimpleSpeciesState {}

class SimpleSpeciesLoading extends SimpleSpeciesState {
  final int? specieskey;

  const SimpleSpeciesLoading({
    required this.specieskey,
  });

  @override
  List<Object> get props => [
        specieskey ?? 0,
      ];
}

class SimpleSpeciesLoaded extends SimpleSpeciesState {
  final SimpleSpecies species;

  const SimpleSpeciesLoaded({
    required this.species,
  });

  @override
  List<Object> get props => [
        species,
      ];
}

class SimpleSpeciesError extends SimpleSpeciesState {
  final String message;

  const SimpleSpeciesError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
