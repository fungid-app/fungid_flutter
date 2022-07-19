part of 'observation_list_cubit.dart';

class ObservationListState extends Equatable {
  const ObservationListState({
    required this.observations,
  });

  final List<UserObservation> observations;

  @override
  List<Object> get props => [];
  ObservationListState copyWith({
    List<UserObservation>? observations,
  }) =>
      ObservationListState(
        observations: observations ?? this.observations,
      );
}
