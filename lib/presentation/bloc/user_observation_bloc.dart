import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:fungid_flutter/domain.dart';

part 'user_observation_event.dart';
part 'user_observation_state.dart';

class UserObservationBloc
    extends Bloc<UserObservationEvent, UserObservationState> {
  UserObservationBloc(this._repository)
      : super(const UserObservationList(
          userObservations: [],
        )) {
    on<ViewObservationList>(_onViewObservationList);
  }

  final UserObservationsRepository _repository;

  void _onViewObservationList(
      ViewObservationList event, Emitter<UserObservationState> emit) async {
    final observations = await _repository.getAllObservations();

    emit(UserObservationList(
      userObservations: observations,
    ));
  }
}
