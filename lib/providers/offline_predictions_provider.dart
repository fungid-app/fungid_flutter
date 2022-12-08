import 'dart:io';

import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/utils/offline_predictions_downloader.dart';
import 'package:local_db/local_db.dart';

class OfflinePredictionsProvider {
  final DatabaseHandler _db;
  int classifierImageSize = 384;
  final OfflinePredictionsDownloader _downloader;

  get currentVersion => _downloader.currentVersion;

  OfflinePredictionsProvider._({
    required String dataPath,
    required DatabaseHandler db,
  })  : _db = db,
        _downloader = OfflinePredictionsDownloader(dataPath: dataPath);

  static Future<OfflinePredictionsProvider> create({
    required String dataPath,
    required DatabaseHandler db,
  }) async {
    var provider = OfflinePredictionsProvider._(
      dataPath: dataPath,
      db: db,
    );

    // Return the fully initialized object
    return provider;
  }

  Future<List<dynamic>?> _getImagePrediction(
    File img,
  ) async {
    return await _downloader.imageModel!.getImagePredictionList(
      img,
      classifierImageSize,
      classifierImageSize,
      // Model not trained with normalization
      std: [1.0, 1.0, 1.0],
      mean: [0.0, 0.0, 0.0],
    );
  }

  Future<List<double>> _getImagesPrediction(
    List<String> images,
  ) async {
    var results = await Future.wait(images.map(
      (img) => _getImagePrediction(
        File(img),
      ),
    ));

    if (results.length != images.length) {
      throw Exception('Results length does not match images length');
    }

    List<double> combinedResults = [];
    double maxScore = 0.0;

    for (int i = 0; i < results.first!.length; i++) {
      var total = 0.0;

      for (var result in results) {
        total += result![i];
      }

      if (maxScore < total) {
        maxScore = total;
      }

      combinedResults.add(total);
    }

    return combinedResults.map((e) => e / results.length).toList();
  }

  Future<List<Prediction>> _makePredictions(
    List<double> results,
    Set<String>? localSpecies,
  ) async {
    if (results.length != _downloader.labels!.length) {
      throw Exception('Image model results and labels are not the same length');
    }

    var predictions = <Prediction>[];

    for (int i = 0; i < results.length; i++) {
      double probability = results[i];
      double localProb = results[i];

      if (localSpecies != null &&
          !localSpecies.contains(_downloader.labels![i])) {
        localProb = 0;
      }

      if (probability > 0.001) {
        int? specieskey =
            (await _db.getSpecies(_downloader.labels![i]))?.speciesKey;

        if (specieskey != null) {
          predictions.add(Prediction(
            specieskey: specieskey,
            species: _downloader.labels![i],
            probability: probability,
            localProbability: localProb,
            imageScore: null,
            isLocal: localProb > 0,
            localScore: localProb > 0 ? probability : null,
            tabScore: null,
          ));
        }
      }
    }

    predictions.sort((a, b) => b.probability.compareTo(a.probability));

    return predictions;
  }

  Future<Predictions> getPredictions(
    String observationID,
    DateTime date,
    List<String> images,
    Set<String>? localSpecies,
  ) async {
    if (!_downloader.isInitialized) {
      throw Exception('Offline predictions are not initialized');
    }

    var results = await _getImagesPrediction(images);

    return Predictions(
      observationID: observationID,
      predictions: await _makePredictions(results, localSpecies),
      dateCreated: DateTime.now().toUtc(),
      inferred: null,
      predictionType: PredictionType.offline,
      modelVersion: _downloader.currentVersion,
    );
  }

  Stream<OfflinePredictionsDownloadStatus> enable() {
    return _downloader.enable();
  }

  Future<void> disable() async {
    return await _downloader.disable();
  }
}
