import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'species_state.dart';

class SpeciesCubit extends Cubit<SpeciesState> {
  SpeciesCubit() : super(SpeciesInitial());
}
