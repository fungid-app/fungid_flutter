import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/providers/fungid_api_provider.dart';
import 'package:fungid_flutter/providers/user_observation_image_provider.dart';
import 'package:fungid_flutter/providers/user_observation_provider.dart';

class UserObservationsRepository {
  const UserObservationsRepository({
    required UserObservationsSharedPrefProvider observationsProvider,
    required UserObservationImageFileSystemProvider imageProvider,
    required FungidApiProvider fungidApiProvider,
  })  : _observationsProvider = observationsProvider,
        _fungidApiProvider = fungidApiProvider,
        _imageProvider = imageProvider;

  final FungidApiProvider _fungidApiProvider;
  final UserObservationsSharedPrefProvider _observationsProvider;
  final UserObservationImageFileSystemProvider _imageProvider;

  Stream<List<UserObservation>> getAllObservations() {
    return _observationsProvider.getObservations();
  }

  UserObservation? getObservation(String id) {
    return _observationsProvider.getObservation(id);
  }

  Future<void> saveObservation(UserObservation obs) async {
    var prevObs = getObservation(obs.id);

    // Save new images
    var images = await Future.wait(obs.images.map((img) async {
      var path = await _imageProvider.saveImage(img);
      return img.copyWith(filename: path);
    }));

    if (prevObs != null) {
      // Delete old images
      for (var img in prevObs.images) {
        if (!obs.images.any((element) => element.id == img.id)) {
          _imageProvider.deleteImage(img.filename);
        }
      }
    }

    return _observationsProvider.saveObservation(obs.copyWith(
      images: images,
    ));
  }

  Future<bool> clearObservations() async {
    return _observationsProvider.clear();
  }

  Future<void> deleteObservation(String id) async {
    var prevObs = getObservation(id);

    // Delete old images
    if (prevObs != null) {
      for (var img in prevObs.images) {
        _imageProvider.deleteImage(img.filename);
      }
    }

    return _observationsProvider.deleteObservation(id);
  }

  Future<Predictions> getPredictions(UserObservation observation) async {
    return _fungidApiProvider.getPredictions(
      observation.id,
      observation.dateCreated,
      observation.location.lat,
      observation.location.lng,
      observation.images,
    );
  }
}
