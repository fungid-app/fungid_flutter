part of 'local_predictions_view_cubit.dart';

class LocalPredictionsViewState extends Equatable {
  final bool showOnlyLocal;
  final List<LocalPrediction> predictions;
  final List<BasicPrediction> visiblePredictions;
  final bool showLocalOption;

  LocalPredictionsViewState({
    this.showOnlyLocal = false,
    required this.predictions,
  })  : showLocalOption = predictions.any((p) => !p.isLocal),
        visiblePredictions = showOnlyLocal
            ? predictions
                .where((p) => p.isLocal)
                .map(
                  (p) => BasicPrediction(
                    specieskey: p.specieskey,
                    probability: p.localProbability,
                  ),
                )
                .toList()
            : predictions {
    visiblePredictions.sort((a, b) => b.probability.compareTo(a.probability));
  }

  @override
  List<Object> get props => [
        showOnlyLocal,
        predictions,
        visiblePredictions,
      ];

  LocalPredictionsViewState copyWith({
    bool? showOnlyLocal,
  }) {
    return LocalPredictionsViewState(
      showOnlyLocal: showOnlyLocal ?? this.showOnlyLocal,
      predictions: predictions,
    );
  }
}
