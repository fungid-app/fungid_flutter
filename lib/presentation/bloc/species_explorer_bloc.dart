import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/repositories/predictions_repository.dart';

part 'species_explorer_event.dart';
part 'species_explorer_state.dart';

class SpeciesExplorerBloc
    extends Bloc<SpeciesExplorerEvent, SpeciesExplorerState> {
  SpeciesExplorerBloc({
    required this.predictionsRepository,
  }) : super(SpeciesExplorerInitial()) {
    on<SpeciesExplorerLoad>(_loadSeasonalSpecies);
  }

  final PredictionsRepository predictionsRepository;

  Future<void> _loadSeasonalSpecies(
    SpeciesExplorerLoad event,
    Emitter<SpeciesExplorerState> emit,
  ) async {
    emit(const SpeciesExplorerLoading());

    try {
      final predictions = await predictionsRepository.getAllSpecies();

      emit(SpeciesExplorerLoaded(
        predictions: predictions,
      ));
    } catch (e) {
      emit(SpeciesExplorerError(message: e.toString()));

      rethrow;
    }
  }
}
