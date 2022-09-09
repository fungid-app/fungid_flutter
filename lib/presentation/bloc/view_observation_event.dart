part of 'view_observation_bloc.dart';

abstract class ViewObservationEvent extends Equatable {
  const ViewObservationEvent();

  @override
  List<Object> get props => [];
}

class ViewObservationSubscriptionRequested extends ViewObservationEvent {
  const ViewObservationSubscriptionRequested();
}

class ViewObservationGetPredctions extends ViewObservationEvent {
  const ViewObservationGetPredctions();
}

class ViewObservationSave extends ViewObservationEvent {
  const ViewObservationSave();
}

class ViewObservationDelete extends ViewObservationEvent {
  const ViewObservationDelete();
}
