import 'dart:typed_data';

import 'package:fungid_flutter/domain.dart';
import 'package:fungid_flutter/providers/user_observation_provider.dart';
import 'package:fungid_flutter/utils/images.dart';
import 'package:uuid/uuid.dart';

class UserObservationsRepository {
  const UserObservationsRepository({
    required UserObservationsSharedPrefProvider provider,
  }) : _provider = provider;

  final UserObservationsSharedPrefProvider _provider;

  Stream<List<UserObservation>> getAllObservations() {
    return _provider.getObservations();
  }

  UserObservation createObservation() {
    final obs = UserObservation(
      id: const Uuid().v4(),
      images: const [],
      location: const ObservationLocation(
        lat: 0.0,
        lng: 0.0,
        placeName: "",
      ),
      dateCreated: DateTime.now(),
    );

    return obs;
  }

  UserObservation addImagesToObservation(
      UserObservation observation, List<String> images) {
    List<UserObservationImage> converted = _convertImages(images);
    observation.images.addAll(converted);

    return observation;
  }

  List<UserObservationImage> _convertImages(List<String> images) {
    var converted = images
        .map((i) => prepareImageFile(i, 1000))
        .whereType<Uint8List>()
        .map(
          (e) => UserObservationImage(imageBytes: e, id: const Uuid().v4()),
        )
        .toList();
    return converted;
  }

  Future<void> saveObservation(UserObservation obs) async {
    return _provider.saveObservation(obs);
  }

  Future<bool> clearObservations() async {
    return _provider.clear();
  }

  Future<void> deleteObservation(String id) async {
    return _provider.deleteObservation(id);
  }
}
