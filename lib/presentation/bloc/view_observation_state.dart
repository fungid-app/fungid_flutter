part of 'view_observation_bloc.dart';

enum ViewObservationStatus {
  initial,
  loading,
  success,
  failure,
}

class ViewObservationState extends Equatable {
  const ViewObservationState({
    this.status = ViewObservationStatus.initial,
    required this.observation,
  });

  final ViewObservationStatus status;
  final UserObservation observation;

  @override
  List<Object> get props => [
        status,
        observation,
      ];

  ViewObservationState copyWith({
    ViewObservationStatus? status,
    UserObservation? observation,
  }) =>
      ViewObservationState(
        status: status ?? this.status,
        observation: observation ?? this.observation,
      );
}
