part of 'observation_list_bloc.dart';

abstract class ObservationListEvent extends Equatable {
  const ObservationListEvent();

  @override
  List<Object> get props => [];
}

class ObservationListSubscriptionRequested extends ObservationListEvent {
  const ObservationListSubscriptionRequested();
}
