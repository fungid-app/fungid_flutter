part of 'filtered_predictions_bloc.dart';

class FilteredPredictionsState extends Equatable {
  final String? searchText;
  final bool showEdible;
  final bool showPoisonous;
  final List<BasicPrediction> predictions;
  final List<BasicPrediction> visiblePredictions;
  final Set<int>? matchedTextSearchIds;

  const FilteredPredictionsState({
    this.searchText,
    this.showEdible = false,
    this.showPoisonous = false,
    required this.predictions,
    required this.visiblePredictions,
    this.matchedTextSearchIds,
  });

  @override
  List<Object> get props => [
        searchText ?? "",
        showEdible,
        showPoisonous,
      ];
}
