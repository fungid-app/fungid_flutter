import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';

part 'species_detail_event.dart';
part 'species_detail_state.dart';

class SpeciesDetailBloc extends Bloc<SpeciesDetailEvent, SpeciesDetailState> {
  SpeciesDetailBloc({
    required this.speciesRepository,
  }) : super(SpeciesDetailInitial()) {
    on<SpeciesDetailInitalizeEvent>(_onInitialize);
  }

  final SpeciesRepository speciesRepository;

  Future<void> _onInitialize(
    SpeciesDetailInitalizeEvent event,
    Emitter<SpeciesDetailState> emit,
  ) async {
    emit(SpeciesDetailInitializing(
      speciesName: event.speciesName,
      speciesKey: event.specieskey,
      observation: event.observation,
    ));

    Species? species;
    if (event.speciesName != null) {
      species = await speciesRepository.getSpecies(event.speciesName!);
    } else if (event.specieskey != null) {
      species = await speciesRepository.getSpeciesByKey(event.specieskey!);
    } else {
      emit(SpeciesDetailFailure(
        message: 'No species name or key provided',
      ));
      return;
    }

    if (species == null) {
      emit(SpeciesDetailFailure(message: "Species not found"));
    } else {
      var similar =
          await speciesRepository.getSimilarSpecies(species.speciesKey);

      emit(SpeciesDetailReady(
        species: species,
        similarSpecies: similar,
        observation: event.observation,
      ));
    }
  }
}
