import 'dart:developer';
import 'dart:io';

import 'package:fungid_api/fungid_api.dart' as api;
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/providers/local_database_provider.dart';
import 'package:fungid_flutter/providers/offline_predictions_provider.dart';
import 'package:fungid_flutter/providers/online_predictions_provider.dart';
import 'package:fungid_flutter/providers/saved_predictions_provider.dart';
import 'package:fungid_flutter/utils/internet.dart';

class PredictionsRepository {
  const PredictionsRepository({
    required SavedPredictionsSharedPrefProvider savedPredictionsProvider,
    required OnlinePredictionsProvider onlinePredictionsProvider,
    required OfflinePredictionsProvider offlinePredictionsProvider,
    required Directory imageStorageDirectory,
    required LocalDatabaseProvider localDatabaseProvider,
  })  : _savedPredictionsProvider = savedPredictionsProvider,
        _onlinePredictionsProvider = onlinePredictionsProvider,
        _offlinePredictionsProvider = offlinePredictionsProvider,
        _localDatabaseProvider = localDatabaseProvider,
        _imageStorageDirectory = imageStorageDirectory;

  final Directory _imageStorageDirectory;
  final OnlinePredictionsProvider _onlinePredictionsProvider;
  final SavedPredictionsSharedPrefProvider _savedPredictionsProvider;
  final OfflinePredictionsProvider _offlinePredictionsProvider;
  final LocalDatabaseProvider _localDatabaseProvider;

  Future<Predictions> getPredictions(UserObservation observation) async {
    Predictions? preds;

    try {
      preds =
          _savedPredictionsProvider.getObservationPredictions(observation.id);
    } catch (e) {
      log(e.toString());
    }

    if (preds == null) {
      return await refreshPredictions(observation);
    }

    return preds;
  }

  Future<Predictions> refreshPredictions(UserObservation observation) async {
    var preds = await _getNewOnlinePredictions(observation);

    // if (!await isOnline()) {
    //   preds = await _getNewOfflinePredictions(observation, null);
    // }

    await _savedPredictionsProvider.saveObservationPredictions(preds);

    return preds;
  }

  Future<Predictions> _getNewOnlinePredictions(
      UserObservation observation) async {
    var preds = await _onlinePredictionsProvider.getPredictions(
      observation.id,
      observation.dateCreated,
      observation.location.lat,
      observation.location.lng,
      observation.images
          .map((e) => e.getFilePath(_imageStorageDirectory))
          .toList(),
    );

    return fromApi(preds, observation.id);
  }

  Future<Prediction?> fromApiPrediction(api.FullPrediction prediction) async {
    int? specieskey =
        await _localDatabaseProvider.getSpeciesKey(prediction.species);

    if (specieskey == null) {
      return null;
    }

    return Prediction(
      specieskey: specieskey,
      species: prediction.species,
      probability: prediction.probability.toDouble(),
      localProbability: prediction.localProbability.toDouble(),
      imageScore: prediction.imageScore.toDouble(),
      tabScore: prediction.tabScore.toDouble(),
      localScore: prediction.localScore.toDouble(),
      isLocal: prediction.isLocal,
    );
  }

  Future<Predictions> fromApi(
    api.FullPredictions apiPreds,
    String observationID,
  ) async {
    var preds = (await Future.wait(
      apiPreds.predictions.map(
        (e) => fromApiPrediction(e),
      ),
    ))
        .whereType<Prediction>()
        .toList();

    return Predictions(
      observationID: observationID,
      predictions: preds,
      dateCreated: DateTime.now().toUtc(),
      inferred: InferredData.fromApi(apiPreds.inferred),
      predictionType: PredictionType.online,
      modelVersion: apiPreds.version,
    );
  }

  Future<Predictions> _getNewOfflinePredictions(
    UserObservation observation,
    Set<String> localSpecies,
  ) async {
    var preds = await _offlinePredictionsProvider.getPredictions(
      observation.id,
      observation.dateCreated,
      observation.images,
      localSpecies,
      _imageStorageDirectory,
    );

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

  Future<List<BasicPrediction>> getSeasonalSpecies({
    required num lat,
    required num lon,
    DateTime? date,
  }) async {
    var preds = _savedPredictionsProvider.getSeasonalPredictions(
      date ?? DateTime.now(),
      lat,
      lon,
    );

    if (preds == null) {
      if (await isOnline()) {
        var seasonal = await _onlinePredictionsProvider.getSeasonalSpecies(
          lat: lat,
          lon: lon,
          date: date != null ? api.Date(date.year, date.month, date.day) : null,
          size: 10000,
          page: 1,
        );

        preds = await _buildBasicPredictionFromApi(seasonal);

        await _savedPredictionsProvider.saveSeasonalPredictions(
          date ?? DateTime.now(),
          lat,
          lon,
          preds,
        );
      } else {
        preds = _savedPredictionsProvider.getLatestSeasonalPredictions();

        if (preds == null) {
          throw Exception(
            'No seasonal predictions available, check to see if you are offline.',
          );
        }
      }
    }

    return preds;
  }

  Future<List<BasicPrediction>> _buildBasicPredictionFromApi(
      List<api.BasicPrediction> preds) async {
    List<BasicPrediction?> basicPreds = await Future.wait(
      preds.map(
        (e) async {
          var specieskey =
              await _localDatabaseProvider.getSpeciesKey(e.species);

          if (specieskey == null) {
            return null;
          }

          return BasicPrediction(
            specieskey: specieskey,
            probability: e.probability,
          );
        },
      ).toList(),
    );

    return basicPreds.whereType<BasicPrediction>().toList();
  }
}
