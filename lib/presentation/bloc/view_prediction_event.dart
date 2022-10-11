part of 'view_prediction_bloc.dart';

abstract class ViewPredictionEvent extends Equatable {
  const ViewPredictionEvent();

  @override
  List<Object> get props => [];
}

class ViewPredictionInitialize extends ViewPredictionEvent {
  const ViewPredictionInitialize();
}

class ViewPredictionSubscriptionRequested extends ViewPredictionEvent {
  const ViewPredictionSubscriptionRequested();
}

class ViewPredictionRefreshPredctions extends ViewPredictionEvent {
  const ViewPredictionRefreshPredctions();
}

class ViewPredictionGetPredctions extends ViewPredictionEvent {
  const ViewPredictionGetPredctions();
}
