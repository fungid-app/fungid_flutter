part of 'filtered_predictions_bloc.dart';

abstract class FilteredPredictionsEvent extends Equatable {
  const FilteredPredictionsEvent();

  @override
  List<Object> get props => [];
}

class EdibleToggledEvent extends FilteredPredictionsEvent {}

class PoisonousToggledEvent extends FilteredPredictionsEvent {}

class SearchTextChangedEvent extends FilteredPredictionsEvent {
  final String? searchText;
  const SearchTextChangedEvent({
    required this.searchText,
  });

  @override
  List<Object> get props => [searchText ?? ""];
}

class FiltersChangedEvent extends FilteredPredictionsEvent {
  final String? searchText;
  final bool showEdible;
  final bool showPoisonous;

  const FiltersChangedEvent({
    this.searchText,
    this.showEdible = false,
    this.showPoisonous = false,
  });

  @override
  List<Object> get props => [
        searchText ?? "",
        showEdible,
        showPoisonous,
      ];
}
