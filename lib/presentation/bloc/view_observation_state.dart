part of 'view_observation_bloc.dart';

enum ViewObservationStatus {
  initial,
  loading,
  success,
  editing,
  failure,
  deleted,
  predictionsLoading,
  predictionsFailed,
}

class ViewObservationState extends Equatable {
  const ViewObservationState({
    this.status = ViewObservationStatus.initial,
    required this.id,
    this.observation,
    this.errorMessage,
    this.predictions,
    this.speciesMap,
  });

  final String id;
  final ViewObservationStatus status;
  final UserObservation? observation;
  final String? errorMessage;
  final Predictions? predictions;
  final Map<String, Species>? speciesMap;

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
    String Function()? errorMessage,
    Predictions Function()? predictions,
    Map<String, Species> Function()? speciesMap,
  }) =>
      ViewObservationState(
        status: status != null ? status() : this.status,
        id: id != null ? id() : this.id,
        observation: observation != null ? observation() : this.observation,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
        predictions: predictions != null ? predictions() : this.predictions,
        speciesMap: speciesMap != null ? speciesMap() : this.speciesMap,
      );
}
