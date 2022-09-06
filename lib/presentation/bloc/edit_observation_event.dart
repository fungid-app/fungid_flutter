part of 'edit_observation_bloc.dart';

abstract class EditObservationEvent extends Equatable {
  const EditObservationEvent();

  @override
  List<Object> get props => [];
}

class InitializeBloc extends EditObservationEvent {
  const InitializeBloc({
    this.images,
  });

  final List<String>? images;
}

class EditObservationLocationChanged extends EditObservationEvent {
  const EditObservationLocationChanged({required this.location});
  final ObservationLocation location;

  @override
  List<Object> get props => [
        location,
      ];
}

class EditObservationAddImages extends EditObservationEvent {
  const EditObservationAddImages({
    required this.images,
  });

  final List<String> images;

  @override
  List<Object> get props => [
        images,
      ];
}

class EditObservationDeleteImage extends EditObservationEvent {
  const EditObservationDeleteImage({
    required this.imageID,
  });

  final String imageID;

  @override
  List<Object> get props => [
        imageID,
      ];
}

class EditObservationDateChanged extends EditObservationEvent {
  const EditObservationDateChanged({
    required this.date,
  });

  final DateTime date;

  @override
  List<Object> get props => [
        date,
      ];
}

class EditObservationSubmitted extends EditObservationEvent {
  const EditObservationSubmitted();
}
