part of 'view_prediction_bloc.dart';

enum ViewPredictionStatus {
  initial,
  loading,
  success,
  editing,
  failure,
  deleted,
  predictionsLoading,
  predictionsFailed,
}

class ViewPredictionState extends Equatable {
  const ViewPredictionState({
    this.status = ViewPredictionStatus.initial,
    required this.observationID,
    this.observation,
    this.errorMessage,
    this.predictions,
    this.imageMap,
    this.isCurrentModelVersion = true,
  });

  final String observationID;
  final ViewPredictionStatus status;
  final UserObservation? observation;
  final String? errorMessage;
  final Predictions? predictions;
  final Map<String, SpeciesImage>? imageMap;
  final bool isCurrentModelVersion;

  bool get isStale => (observation?.lastUpdated ?? DateTime.now())
      .subtract(const Duration(seconds: 1))
      .isAfter(predictions?.dateCreated ?? DateTime.now());

  @override
  List<Object> get props => [
        status,
        observationID,
        observation ?? '',
      ];

  ViewPredictionState copyWith({
    ViewPredictionStatus Function()? status,
    UserObservation Function()? observation,
    String Function()? id,
    String Function()? errorMessage,
    Predictions Function()? predictions,
    Map<String, SpeciesImage> Function()? imageMap,
    bool Function()? isCurrentModelVersion,
  }) =>
      ViewPredictionState(
        status: status != null ? status() : this.status,
        observationID: id != null ? id() : observationID,
        observation: observation != null ? observation() : this.observation,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
        predictions: predictions != null ? predictions() : this.predictions,
        imageMap: imageMap != null ? imageMap() : this.imageMap,
        isCurrentModelVersion: isCurrentModelVersion != null
            ? isCurrentModelVersion()
            : this.isCurrentModelVersion,
      );
}
