import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:intl/intl.dart';
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
          location: intialObservation?.location,
          id: intialObservation?.id,
          dateCreated: intialObservation?.dateCreated,
          observationDate: intialObservation?.observationDate,
          lastUpdated: intialObservation?.lastUpdated,
          images: intialObservation?.images ?? [],
          intialObservation: intialObservation,
          notes: intialObservation?.notes,
        )) {
    on<InitializeBloc>(_onInitializeBloc);
    on<EditObservationLocationChanged>(_onEditObservationLocationChanged);
    on<EditObservationAddImages>(_onEditObservationAddImages);
    on<EditObservationDateChanged>(_onEditObservationDateChanged);
    on<EditObservationSubmitted>(_onEditObservationSubmitted);
    on<EditObservationDeleteImage>(_onEditObservationDeleteImage);
    on<EditObservationNotesChanged>(_onEditObservationNotesChanged);
  }

  final UserObservationsRepository observationRepository;
  final LocationRepository locationRepository;
  final UserObservation? intialObservation;

  void _onInitializeBloc(
    InitializeBloc event,
    Emitter<EditObservationState> emit,
  ) async {
    if (state.status != EditObservationStatus.uninitialized) {
      emit(state.copyWith(
        status: EditObservationStatus.failure,
      ));
    }

    if (state.isNewObservation) {
      var location = await locationRepository.determinePosition();
      var now = DateTime.now();

      emit(state.copyWith(
        location: location,
        dateCreated: now.toUtc(),
        observationDate: DateTime(now.year, now.month, now.day),
        lastUpdated: now.toUtc(),
        id: const Uuid().v4(),
      ));
    }

    if (event.images != null) {
      add(EditObservationAddImages(images: event.images!));
    }

    emit(
      state.copyWith(status: EditObservationStatus.ready),
    );
  }

  Future<void> _onEditObservationLocationChanged(
    EditObservationLocationChanged event,
    Emitter<EditObservationState> emit,
  ) async {
    ObservationLocation location = ObservationLocation(
      lat: event.latitude,
      lng: event.longitude,
      placeName: await locationRepository.getLocationName(
          event.latitude, event.longitude),
    );

    emit(state.copyWith(location: location));
  }

  void _onEditObservationNotesChanged(
    EditObservationNotesChanged event,
    Emitter<EditObservationState> emit,
  ) {
    emit(state.copyWith(notes: event.notes));
  }

  void _onEditObservationAddImages(
      EditObservationAddImages event, Emitter<EditObservationState> emit) {
    List<UserObservationImage> converted = event.images
        .map(
          (e) => UserObservationImage(filename: e, id: const Uuid().v4()),
        )
        .toList();

    var images = [...state.images];

    images.addAll(converted);

    emit(state.copyWith(
      images: images,
    ));
  }

  void _onEditObservationDeleteImage(
      EditObservationDeleteImage event, Emitter<EditObservationState> emit) {
    var images = [...state.images];
    log('Deleting image ${event.imageID} - images: ${images.length}');
    images.removeWhere((element) => element.id == event.imageID);

    log('Images after delete: ${images.length}');
    emit(state.copyWith(
      images: images,
    ));
  }

  void _onEditObservationDateChanged(
      EditObservationDateChanged event, Emitter<EditObservationState> emit) {
    emit(state.copyWith(observationDate: event.date));
  }

  Future<void> _onEditObservationSubmitted(
    EditObservationSubmitted event,
    Emitter<EditObservationState> emit,
  ) async {
    emit(state.copyWith(status: EditObservationStatus.loading));

    final observation = UserObservation(
      id: state.intialObservation?.id ?? state.id!,
      location: state.location!,
      dateCreated: state.dateCreated!,
      observationDate: state.observationDate ?? state.dateCreated!,
      images: state.images,
      lastUpdated: DateTime.now().toUtc(),
      notes: state.notes,
    );

    try {
      await observationRepository.saveObservation(observation);
      emit(state.copyWith(status: EditObservationStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditObservationStatus.failure));
      rethrow;
    }
  }
}
