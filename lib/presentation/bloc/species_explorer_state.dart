part of 'species_explorer_bloc.dart';

abstract class SpeciesExplorerState extends Equatable {
  const SpeciesExplorerState();

  @override
  List<Object> get props => [];
}

class SpeciesExplorerInitial extends SpeciesExplorerState {}

class SpeciesExplorerLoading extends SpeciesExplorerState {
  const SpeciesExplorerLoading();

  @override
  List<Object> get props => [];
}

class SpeciesExplorerLoaded extends SpeciesExplorerState {
  final List<BasicPrediction> predictions;
  final Set<int> localSpeciesKeys;

  SpeciesExplorerLoaded({
    required this.predictions,
  }) : localSpeciesKeys = predictions.map((p) => p.specieskey).toSet();

  @override
  List<Object> get props => [
        predictions,
      ];
}

class SpeciesExplorerError extends SpeciesExplorerState {
  final String message;

  const SpeciesExplorerError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
