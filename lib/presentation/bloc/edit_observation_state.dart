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
    this.observationDate,
    this.lastUpdated,
    this.images,
    this.intialObservation,
  });

  final ObservationLocation? location;
  final String? id;
  final DateTime? dateCreated;
  final DateTime? observationDate;
  final DateTime? lastUpdated;
  final List<UserObservationImage>? images;
  final UserObservation? intialObservation;
  final EditObservationStatus status;

  bool get isNewObservation => intialObservation == null;

  String get formattedDate => observationDate == null
      ? ""
      : DateFormat.yMMMd().format(observationDate!);

  EditObservationState copyWith({
    ObservationLocation? location,
    String? id,
    DateTime? dateCreated,
    DateTime? observationDate,
    DateTime? lastUpdated,
    List<UserObservationImage>? images,
    UserObservation? intialObservation,
    EditObservationStatus? status,
  }) {
    return EditObservationState(
      location: location ?? this.location,
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      observationDate: observationDate ?? this.observationDate,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      images: images ?? this.images,
      intialObservation: intialObservation ?? this.intialObservation,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        location,
        id,
        dateCreated,
        observationDate,
        lastUpdated,
        images,
        status,
      ];
}
