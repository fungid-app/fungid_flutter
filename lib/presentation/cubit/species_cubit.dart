import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'species_state.dart';

class SpeciesCubit extends Cubit<SpeciesState> {
  SpeciesCubit() : super(SpeciesInitial());
}
