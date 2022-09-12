part of 'edit_observation_bloc.dart';

enum EditObservationStatus {
  uninitialized,
  ready,
  loading,
  updating,
  success,
  failure,
}

extension EditObservationStatusX on EditObservationStatus {
  bool get isLoading => [
        EditObservationStatus.loading,
      ].contains(this);
}

class EditObservationState extends Equatable {
  const EditObservationState({
    this.status = EditObservationStatus.uninitialized,
    this.location,
    this.id,
    this.dateCreated,
    this.lastUpdated,
    this.images,
    this.predictions,
    this.intialObservation,
  });

  final ObservationLocation? location;
  final String? id;
  final DateTime? dateCreated;
  final DateTime? lastUpdated;
  final List<UserObservationImage>? images;
  final Predictions? predictions;
  final UserObservation? intialObservation;
  final EditObservationStatus status;

  bool get isNewObservation => intialObservation == null;

  EditObservationState copyWith({
    ObservationLocation? location,
    String? id,
    DateTime? dateCreated,
    DateTime? lastUpdated,
    List<UserObservationImage>? images,
    Predictions? predictions,
    UserObservation? intialObservation,
    EditObservationStatus? status,
  }) {
    return EditObservationState(
      location: location ?? this.location,
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      images: images ?? this.images,
      predictions: predictions ?? this.predictions,
      intialObservation: intialObservation ?? this.intialObservation,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        location,
        id,
        dateCreated,
        lastUpdated,
        images,
        predictions,
        status,
      ];
}
