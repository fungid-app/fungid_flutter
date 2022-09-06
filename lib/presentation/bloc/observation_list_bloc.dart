import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/domain.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';

part 'observation_list_event.dart';
part 'observation_list_state.dart';

class ObservationListBloc
    extends Bloc<ObservationListEvent, ObservationListState> {
  ObservationListBloc({
    required UserObservationsRepository repository,
  })  : _repository = repository,
        super(
          const ObservationListState(),
        ) {
    on<ObservationListSubscriptionRequested>(_onSubscriptionRequested);
  }

  final UserObservationsRepository _repository;

  Future<void> _onSubscriptionRequested(
    ObservationListSubscriptionRequested event,
    Emitter<ObservationListState> emit,
  ) async {
    emit(state.copyWith(status: () => ObservationListStatus.loading));

    await emit.forEach<List<UserObservation>>(
      _repository.getAllObservations(),
      onData: (obs) => state.copyWith(
        status: () => ObservationListStatus.success,
        observations: () => obs,
      ),
      onError: (_, __) => state.copyWith(
        status: () => ObservationListStatus.failure,
      ),
    );
  }
}
