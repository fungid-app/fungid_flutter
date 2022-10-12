import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/domain/predictions.dart';
// import 'package:pytorch_mobile/model.dart';
// import 'package:pytorch_mobile/pytorch_mobile.dart';

class OfflinePredictionsProvider {
  final String _modelPath;
  final String _labelPath;
  List<String>? _labels;
  // Model? _imageModel;
  String currentVersion = "0.4.1";

  OfflinePredictionsProvider._({
    required String modelPath,
    required String labelPath,
  })  : _modelPath = modelPath,
        _labelPath = labelPath;

  static Future<OfflinePredictionsProvider> create(
    String modelPath,
    String labelPath,
  ) async {
    var provider = OfflinePredictionsProvider._(
      modelPath: modelPath,
      labelPath: labelPath,
    );

    await provider._init();

    // Return the fully initialized object
    return provider;
  }

  Future<void> _init() async {
    log('Loading model from $_modelPath');
    try {
      await Future.wait([
        // PyTorchMobile.loadModel(_modelPath),
        rootBundle.loadString(_labelPath),
      ]).then((results) {
        // _imageModel = results[0] as Model;
        log('Model loaded');
        _labels = (results[1]).split('\n');
        log('Found ${_labels!.length} labels');
      });
    } catch (e) {
      log('Error loading model: $e');
    }
  }

  Future<List<dynamic>?> getImagePrediction(
    File img,
  ) async {
    // return await _imageModel!.getImagePredictionList(img, 384, 384);
    return [];
  }

  Future<List<double>> getImagesPrediction(
    List<UserObservationImage> images,
    Directory imagesDirectory,
  ) async {
    var results = await Future.wait(images.map(
      (img) => getImagePrediction(img.getFile(imagesDirectory)),
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

  List<Prediction> _makePredictions(
    List<double> results,
    Set<String>? localSpecies,
  ) {
    if (results.length != _labels!.length) {
      throw Exception('Image model results and labels are not the same length');
    }

    var predictions = <Prediction>[];

    for (int i = 0; i < results.length; i++) {
      double probability = results[i];
      double localProb = probability;

      if (localSpecies != null && !localSpecies.contains(_labels![i])) {
        localProb = localProb * 0.1;
      }

      if (probability > 0.001) {
        predictions.add(Prediction(
          species: _labels![i],
          probability: probability,
          localProbability: localProb,
          imageScore: null,
          isLocal: null,
          localScore: null,
          tabScore: null,
        ));
      }
    }

    predictions.sort((a, b) => b.probability.compareTo(a.probability));

    return predictions;
  }

  Future<Predictions> getPredictions(
    String observationID,
    DateTime date,
    List<UserObservationImage> images,
    Set<String>? localSpecies,
    Directory imagesDirectory,
  ) async {
    var results = await getImagesPrediction(images, imagesDirectory);

    return Predictions(
      observationID: observationID,
      predictions: _makePredictions(results, localSpecies),
      dateCreated: DateTime.now().toUtc(),
      inferred: null,
      predictionType: PredictionType.offline,
      modelVersion: currentVersion,
    );
  }
}
