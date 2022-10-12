import 'dart:developer';

import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/providers/offline_predictions_provider.dart';
import 'package:fungid_flutter/providers/online_predictions_provider.dart';
import 'package:fungid_flutter/providers/saved_predictions_provider.dart';
import 'package:fungid_flutter/providers/user_observation_image_provider.dart';

class PredictionsRepository {
  const PredictionsRepository({
    required SavedPredictionsSharedPrefProvider savedPredictionsProvider,
    required OnlinePredictionsProvider onlinePredictionsProvider,
    required OfflinePredictionsProvider offlinePredictionsProvider,
    required UserObservationImageFileSystemProvider imageProvider,
  })  : _savedPredictionsProvider = savedPredictionsProvider,
        _onlinePredictionsProvider = onlinePredictionsProvider,
        _offlinePredictionsProvider = offlinePredictionsProvider,
        _imageProvider = imageProvider;

  final UserObservationImageFileSystemProvider _imageProvider;
  final OnlinePredictionsProvider _onlinePredictionsProvider;
  final SavedPredictionsSharedPrefProvider _savedPredictionsProvider;
  final OfflinePredictionsProvider _offlinePredictionsProvider;

  Future<Predictions> getOnlinePredictions(UserObservation observation) async {
    var preds = _savedPredictionsProvider.getPredictions(observation.id);

    if (preds == null) {
      return await getNewOnlinePredictions(observation);
    }

    return preds;
  }

  Future<Predictions> getNewOnlinePredictions(
      UserObservation observation) async {
    var preds = await _onlinePredictionsProvider.getPredictions(
      observation.id,
      observation.dateCreated,
      observation.location.lat,
      observation.location.lng,
      observation.images,
      _imageProvider.storageDirectory,
    );

    await _savedPredictionsProvider.savePredictions(preds);
    return preds;
  }

  Future<Predictions> getOfflinePredictions(
    UserObservation observation,
    Set<String>? localSpecies,
  ) async {
    var preds = _savedPredictionsProvider.getPredictions(observation.id);

    if (preds == null) {
      return await getNewOfflinePredictions(
        observation,
        localSpecies,
      );
    }

    return preds;
  }

  Future<Predictions> getNewOfflinePredictions(
    UserObservation observation,
    Set<String>? localSpecies,
  ) async {
    var preds = await _offlinePredictionsProvider.getPredictions(
      observation.id,
      observation.dateCreated,
      observation.images,
      localSpecies,
      _imageProvider.storageDirectory,
    );

    await _savedPredictionsProvider.savePredictions(preds);
    return preds;
  }

  bool isCurrentVersion(Predictions preds) {
    return preds.predictionType == PredictionType.offline
        ? _isCurrentOfflineVersion(preds.modelVersion)
        : _isCurrentOnlineVersion(preds.modelVersion);
  }

  bool _isCurrentOnlineVersion(String? version) {
    var curVersion = _onlinePredictionsProvider.currentVersion;
    log('Current online version: $curVersion vs $version');
    return version == (curVersion ?? version);
  }

  bool _isCurrentOfflineVersion(String? version) {
    var curVersion = _offlinePredictionsProvider.currentVersion;
    return version == curVersion;
  }
}
