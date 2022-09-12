part of 'view_observation_bloc.dart';

enum ViewObservationStatus {
  initial,
  loading,
  success,
  editing,
  failure,
  deleted,
  predictionsLoading,
}

class ViewObservationState extends Equatable {
  const ViewObservationState({
    this.status = ViewObservationStatus.initial,
    required this.id,
    this.observation,
  });

  final String id;
  final ViewObservationStatus status;
  final UserObservation? observation;

  @override
  List<Object> get props => [
        status,
        id,
        observation ?? '',
      ];

  ViewObservationState copyWith({
    ViewObservationStatus Function()? status,
    UserObservation Function()? observation,
    String Function()? id,
  }) =>
      ViewObservationState(
        status: status != null ? status() : this.status,
        id: id != null ? id() : this.id,
        observation: observation != null ? observation() : this.observation,
      );
}
