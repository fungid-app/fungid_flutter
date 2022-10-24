import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';

part 'simple_species_event.dart';
part 'simple_species_state.dart';

class SimpleSpeciesBloc extends Bloc<SimpleSpeciesEvent, SimpleSpeciesState> {
  SimpleSpeciesBloc({
    required this.speciesRepository,
  }) : super(SimpleSpeciesInitial()) {
    on<SimpleSpeciesLoad>(_load);
  }

  final SpeciesRepository speciesRepository;

  Future<void> _load(
    SimpleSpeciesLoad event,
    Emitter<SimpleSpeciesState> emit,
  ) async {
    emit(SimpleSpeciesLoading(
      specieskey: event.specieskey,
    ));

    try {
      final species = await speciesRepository.getSimpleSpecies(
        event.specieskey,
      );

      if (species != null) {
        emit(SimpleSpeciesLoaded(
          species: species,
        ));
      } else {
        emit(const SimpleSpeciesError(
          message: "Species not found",
        ));
      }
    } catch (e) {
      emit(SimpleSpeciesError(message: e.toString()));

      rethrow;
    }
  }
}
