import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:fungid_flutter/domain.dart';

part 'observation_list_state.dart';

class ObservationListCubit extends Cubit<ObservationListState> {
  ObservationListCubit(this._repository)
      : super(const ObservationListState(
          observations: [],
        ));

  final UserObservationsRepository _repository;

  fetchObservations() {
    final observations = _repository.getAllObservations();

    emit(state.copyWith(observations: observations));
  }
}
