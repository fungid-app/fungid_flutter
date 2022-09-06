part of 'observation_list_bloc.dart';

enum ObservationListStatus {
  initial,
  loading,
  success,
  failure,
}

class ObservationListState extends Equatable {
  const ObservationListState({
    this.observations = const [],
    this.status = ObservationListStatus.initial,
  });

  final List<UserObservation> observations;
  final ObservationListStatus status;

  @override
  List<Object> get props => [
        observations,
        status,
      ];

  ObservationListState copyWith({
    List<UserObservation> Function()? observations,
    ObservationListStatus Function()? status,
  }) =>
      ObservationListState(
        observations: observations != null ? observations() : this.observations,
        status: status != null ? status() : this.status,
      );
}
