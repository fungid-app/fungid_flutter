import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';

part 'observation_image_state.dart';

class ObservationImageCubit extends Cubit<ObservationImageState> {
  UserObservationsRepository userObservationsRepository;
  ObservationImageCubit({
    required this.userObservationsRepository,
  }) : super(ObservationImageState(
          storageDirectory: userObservationsRepository.imageStorageDirectory,
        ));
}
