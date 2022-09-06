import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:fungid_flutter/domain.dart';
import 'package:fungid_flutter/utils/images.dart';
import 'package:uuid/uuid.dart';

part 'edit_observation_event.dart';
part 'edit_observation_state.dart';

class EditObservationBloc
    extends Bloc<EditObservationEvent, EditObservationState> {
  EditObservationBloc({
    required this.observationRepository,
    required this.locationRepository,
    required this.intialObservation,
  }) : super(EditObservationState(
          status: EditObservationStatus.initial,
          location: intialObservation?.location,
          id: intialObservation?.id,
          dateCreated: intialObservation?.dateCreated,
          lastUpdated: intialObservation?.lastUpdated,
          images: intialObservation?.images,
          predictions: intialObservation?.predictions,
          intialObservation: intialObservation,
        )) {
    on<InitializeBloc>(_onInitializeBloc);
    on<EditObservationLocationChanged>(_onEditObservationLocationChanged);
    on<EditObservationAddImages>(_onEditObservationAddImages);
    on<EditObservationDateChanged>(_onEditObservationDateChanged);
    on<EditObservationSubmitted>(_onEditObservationSubmitted);
    on<EditObservationDeleteImage>(_onEditObservationDeleteImage);
  }

  final UserObservationsRepository observationRepository;
  final LocationRepository locationRepository;
  final UserObservation? intialObservation;

  void _onInitializeBloc(
    InitializeBloc event,
    Emitter<EditObservationState> emit,
  ) async {
    if (state.status != EditObservationStatus.initial) {
      emit(state.copyWith(
        status: EditObservationStatus.failure,
      ));
    }

    if (state.isNewObservation) {
      var location = await locationRepository.determinePosition();

      emit(state.copyWith(
        location: location,
        dateCreated: DateTime.now(),
        lastUpdated: DateTime.now(),
        id: const Uuid().v4(),
      ));
    }

    if (event.images != null) {
      add(EditObservationAddImages(images: event.images!));
    }
  }

  void _onEditObservationLocationChanged(
    EditObservationLocationChanged event,
    Emitter<EditObservationState> emit,
  ) {
    emit(state.copyWith(location: event.location));
  }

  void _onEditObservationAddImages(
      EditObservationAddImages event, Emitter<EditObservationState> emit) {
    List<UserObservationImage> converted = event.images
        .map((i) => getBytesFromFile(i))
        .whereType<Uint8List>()
        .map(
          (e) => UserObservationImage(imageBytes: e, id: const Uuid().v4()),
        )
        .toList();

    converted.addAll(state.images ?? []);

    emit(state.copyWith(images: converted));
  }

  void _onEditObservationDeleteImage(
      EditObservationDeleteImage event, Emitter<EditObservationState> emit) {
    var images = (state.images ?? []);
    images.removeWhere((element) => element.id == event.imageID);

    emit(state.copyWith(images: images));
  }

  void _onEditObservationDateChanged(
      EditObservationDateChanged event, Emitter<EditObservationState> emit) {
    emit(state.copyWith(dateCreated: event.date));
  }

  Future<void> _onEditObservationSubmitted(
    EditObservationSubmitted event,
    Emitter<EditObservationState> emit,
  ) async {
    emit(state.copyWith(status: EditObservationStatus.loading));

    final observation = state.intialObservation ??
        UserObservation(
          id: state.id!,
          location: state.location!,
          dateCreated: state.dateCreated!,
          images: state.images!,
          predictions: state.predictions,
        );

    try {
      await observationRepository.saveObservation(observation);
      emit(state.copyWith(status: EditObservationStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditObservationStatus.failure));
    }
  }
}
