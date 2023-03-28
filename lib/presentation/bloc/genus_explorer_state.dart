part of 'genus_explorer_bloc.dart';

abstract class GenusExplorerState extends Equatable {
  const GenusExplorerState();

  @override
  List<Object> get props => [];
}

class GenusExplorerInitial extends GenusExplorerState {}

class GenusExplorerLoading extends GenusExplorerState {
  const GenusExplorerLoading();

  @override
  List<Object> get props => [];
}

class GenusExplorerLoaded extends GenusExplorerState {
  final List<BasicPrediction> predictions;
  final Set<int> localSpeciesKeys;

  GenusExplorerLoaded({
    required this.predictions,
  }) : localSpeciesKeys = predictions.map((p) => p.specieskey).toSet();

  @override
  List<Object> get props => [
        predictions,
      ];
}

class GenusExplorerError extends GenusExplorerState {
  final String message;

  const GenusExplorerError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
