import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/data.dart';
import 'package:fungid_flutter/domain.dart';

part 'user_observation_event.dart';
part 'user_observation_state.dart';

class UserObservationBloc
    extends Bloc<UserObservationEvent, UserObservationState> {
  UserObservationBloc(this._repository)
      : super(const UserObservationList(
          userObservations: [],
        )) {
    on<UserObservationEvent>((event, emit) {});
  }

  final UserObservationsRepository _repository;
}
