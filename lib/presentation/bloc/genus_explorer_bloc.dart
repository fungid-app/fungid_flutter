import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/repositories/predictions_repository.dart';

part 'genus_explorer_event.dart';
part 'genus_explorer_state.dart';

class GenusExplorerBloc extends Bloc<GenusExplorerEvent, GenusExplorerState> {
  GenusExplorerBloc({
    required this.predictionsRepository,
  }) : super(GenusExplorerInitial()) {
    on<GenusExplorerLoad>(_loadSeasonalSpecies);
  }

  final PredictionsRepository predictionsRepository;

  Future<void> _loadSeasonalSpecies(
    GenusExplorerLoad event,
    Emitter<GenusExplorerState> emit,
  ) async {
    emit(const GenusExplorerLoading());

    try {
      final predictions = await predictionsRepository.getAllSpecies();

      emit(GenusExplorerLoaded(
        predictions: predictions,
      ));
    } catch (e) {
      emit(GenusExplorerError(message: e.toString()));

      rethrow;
    }
  }
}
