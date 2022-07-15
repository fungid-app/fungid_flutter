part of 'user_observation_bloc.dart';

abstract class UserObservationEvent extends Equatable {
  const UserObservationEvent();

  @override
  List<Object> get props => [];
}

class SingleObservationEvent extends UserObservationEvent {
  const SingleObservationEvent({
    required this.observation,
  });

  final UserObservation observation;

  @override
  List<Object> get props => [observation];
}

class StartObservation extends UserObservationEvent {
  const StartObservation();

  @override
  List<Object> get props => [];
}

class ImageTaken extends SingleObservationEvent {
  const ImageTaken({
    required observation,
  }) : super(observation: observation);
}

class GetPredictions extends SingleObservationEvent {
  const GetPredictions({
    required observation,
  }) : super(observation: observation);
}

class UpdateObservationDate extends SingleObservationEvent {
  const UpdateObservationDate({
    required observation,
  }) : super(observation: observation);
}

class UpdateObservationLocation extends SingleObservationEvent {
  const UpdateObservationLocation({
    required observation,
  }) : super(observation: observation);
}

class ReturnToList extends UserObservationEvent {
  const ReturnToList();
}

class DeleteObservation extends SingleObservationEvent {
  const DeleteObservation({
    required observation,
  }) : super(observation: observation);
}
