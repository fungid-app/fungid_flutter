part of 'simple_species_bloc.dart';

abstract class SimpleSpeciesEvent extends Equatable {
  const SimpleSpeciesEvent();

  @override
  List<Object> get props => [];
}

class SimpleSpeciesLoad extends SimpleSpeciesEvent {
  final int specieskey;

  const SimpleSpeciesLoad({
    required this.specieskey,
  });

  @override
  List<Object> get props => [
        specieskey,
      ];
}
