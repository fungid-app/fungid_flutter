import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/domain/observations.dart';
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
      observation: event.observation,
    ));

    var species = await speciesRepository.getSpecies(event.speciesName);

    if (species == null) {
      emit(SpeciesDetailFailure(message: "Species not found"));
    } else {
      emit(SpeciesDetailReady(
        species: species,
        observation: event.observation,
      ));
    }
  }
}
