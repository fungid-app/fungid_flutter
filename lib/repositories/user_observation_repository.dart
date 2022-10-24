import 'dart:io';

import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/providers/user_observation_image_provider.dart';
import 'package:fungid_flutter/providers/user_observation_provider.dart';

class UserObservationsRepository {
  const UserObservationsRepository({
    required SharedPrefsStorageProvider observationsProvider,
    required UserObservationImageFileSystemProvider imageProvider,
  })  : _observationsProvider = observationsProvider,
        _imageProvider = imageProvider;

  final SharedPrefsStorageProvider _observationsProvider;
  final UserObservationImageFileSystemProvider _imageProvider;

  Stream<List<UserObservation>> getAllObservations() {
    return _observationsProvider.getObservations();
  }

  UserObservation? getObservation(String id) {
    return _observationsProvider.getObservation(id);
  }

  Future<void> saveObservation(
    UserObservation obs,
    List<UserObservationImageBase> tmpImages,
  ) async {
    var prevObs = getObservation(obs.id);
    List<UserObservationImage> images = [];

    // Save new images
    for (var image in tmpImages) {
      var img = await _imageProvider.saveImage(image);
      images.add(img);
    }

    if (prevObs != null) {
      // Delete old images
      for (var img in prevObs.images) {
        if (!images.any((element) => element.id == img.id)) {
          _imageProvider.deleteImage(
            img.getFilePath(_imageProvider.storageDirectory),
          );
        }
      }
    }

    return _observationsProvider.saveObservation(obs.copyWith(
      images: images,
    ));
  }

  Directory get imageStorageDirectory => _imageProvider.storageDirectory;

  Future<bool> clearObservations() async {
    return _observationsProvider.clear();
  }

  Future<void> deleteObservation(String id) async {
    var prevObs = getObservation(id);

    // Delete old images
    if (prevObs != null) {
      for (var img in prevObs.images) {
        _imageProvider.deleteImage(
          img.getFilePath(_imageProvider.storageDirectory),
        );
      }
    }

    return _observationsProvider.deleteObservation(id);
  }
}
