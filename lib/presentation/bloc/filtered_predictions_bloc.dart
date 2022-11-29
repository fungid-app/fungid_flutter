import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';

part 'filtered_predictions_event.dart';
part 'filtered_predictions_state.dart';

class FilteredPredictionsBloc
    extends Bloc<FilteredPredictionsEvent, FilteredPredictionsState> {
  FilteredPredictionsBloc({
    required List<BasicPrediction> predictions,
    required this.speciesRepository,
  }) : super(FilteredPredictionsState(
          predictions: predictions,
          visiblePredictions: predictions,
        )) {
    on<EdibleToggledEvent>(_edibleToggled);
    on<PoisonousToggledEvent>(_poisonousToggled);
    on<SearchTextChangedEvent>(_searchTextChanged);
  }
  final SpeciesRepository speciesRepository;

  Future<void> _edibleToggled(
    EdibleToggledEvent event,
    Emitter<FilteredPredictionsState> emit,
  ) async {
    await updateResults(
      !state.showEdible,
      state.showPoisonous,
      state.searchText,
      state.matchedTextSearchIds,
      emit,
    );
  }

  Future<void> _poisonousToggled(
    PoisonousToggledEvent event,
    Emitter<FilteredPredictionsState> emit,
  ) async {
    await updateResults(
      state.showEdible,
      !state.showPoisonous,
      state.searchText,
      state.matchedTextSearchIds,
      emit,
    );
  }

  Future<void> _searchTextChanged(
    SearchTextChangedEvent event,
    Emitter<FilteredPredictionsState> emit,
  ) async {
    Set<int>? matchedTextSearchIds;

    if (event.searchText == state.searchText) {
      matchedTextSearchIds = state.matchedTextSearchIds;
    } else if (event.searchText != null && event.searchText!.isNotEmpty) {
      matchedTextSearchIds =
          await speciesRepository.searchSpecies(event.searchText!);
    }

    await updateResults(
      state.showEdible,
      state.showPoisonous,
      event.searchText,
      matchedTextSearchIds,
      emit,
    );
  }

  Future<void> updateResults(
    bool showEdible,
    bool showPoisonous,
    String? searchText,
    Set<int>? matchedTextSearchIds,
    Emitter<FilteredPredictionsState> emit,
  ) async {
    Set<int>? visibleIds;

    if (showEdible) {
      visibleIds = await speciesRepository.getEdibleSpeciesKeys();
    }

    if (showPoisonous) {
      var p = await speciesRepository.getPoisonousSpeciesKeys();
      visibleIds = visibleIds == null ? p : visibleIds.union(p);
    }

    if (matchedTextSearchIds != null) {
      visibleIds = visibleIds == null
          ? matchedTextSearchIds
          : visibleIds.intersection(matchedTextSearchIds);
    }

    final filteredPredictions = visibleIds == null
        ? state.predictions
        : state.predictions.where((p) {
            return visibleIds!.contains(p.specieskey);
          }).toList();

    emit(FilteredPredictionsState(
      searchText: searchText,
      showEdible: showEdible,
      showPoisonous: showPoisonous,
      predictions: state.predictions,
      visiblePredictions: filteredPredictions,
      matchedTextSearchIds: matchedTextSearchIds,
    ));
  }
}
