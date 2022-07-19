part of 'user_observation_bloc.dart';

abstract class UserObservationState extends Equatable {
  const UserObservationState();

  @override
  List<Object> get props => [];
}

class UserObservationList extends UserObservationState {
  const UserObservationList({
    required this.userObservations,
  });

  final List<UserObservation> userObservations;

  @override
  List<Object> get props => [
        userObservations,
      ];
}

class UserObservationCamera extends UserObservationState {
  const UserObservationCamera({
    required this.cameras,
    this.observation,
  });

  final UserObservation? observation;
  final List<CameraDescription> cameras;

  @override
  List<Object> get props => [
        observation ?? "",
      ];
}

class UserObservationView extends UserObservationState {
  const UserObservationView({
    required this.observation,
  });

  final UserObservation observation;

  @override
  List<Object> get props => [
        observation,
      ];
}
