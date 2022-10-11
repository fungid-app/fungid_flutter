part of 'view_observation_bloc.dart';

abstract class ViewObservationEvent extends Equatable {
  const ViewObservationEvent();

  @override
  List<Object> get props => [];
}

class ViewObservationInitialize extends ViewObservationEvent {
  const ViewObservationInitialize();
}

class ViewObservationSubscriptionRequested extends ViewObservationEvent {
  const ViewObservationSubscriptionRequested();
}

class ViewObservationEdit extends ViewObservationEvent {
  const ViewObservationEdit();
}

class ViewObservationDelete extends ViewObservationEvent {
  const ViewObservationDelete();
}
