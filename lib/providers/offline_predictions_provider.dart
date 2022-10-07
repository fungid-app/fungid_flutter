import 'dart:io';

import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:pytorch_mobile_v2/model.dart';

class OfflinePredictionsProvider {
  final String _modelPath;
  final String _labelPath;
  List<String>? _labels;
  Model? _imageModel;

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
    // log('Loading model from $_modelPath');
    // _imageModel = await PyTorchMobile.loadModel(_modelPath);
    // log('Model loaded');
    // File labelFile = File(_labelPath);
    // if (!await labelFile.exists()) {
    //   throw Exception('Image classifier label file does not exist');
    // }
    // _labels = await labelFile.readAsLines();
  }

  Future<List<double>?> getImagePrediction(
    String imgPath,
  ) {
    File imgFile = File(imgPath);
    return _imageModel!.getImagePredictionList(imgFile, 385, 385)
        as Future<List<double>?>;
  }

  Future<List<double>> getImagesPrediction(
    List<UserObservationImage> images,
  ) async {
    var results = await Future.wait(images.map(
      (img) async => getImagePrediction(img.filename),
    ));

    var validResults = results.whereType<List<double>>();

    List<double> combinedResults = [];

    for (int i = 0; i < validResults.first.length; i++) {
      var sum = 0.0;
      for (var result in validResults) {
        sum += result[i];
      }
      combinedResults.add(sum / validResults.length);
    }

    return combinedResults;
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

    predictions.sort((a, b) => b.probability.compareTo(a.probability));

    return predictions;
  }

  Future<Predictions> getPredictions(
    String observationID,
    DateTime date,
    List<UserObservationImage> images,
    Set<String>? localSpecies,
  ) async {
    var results = await getImagesPrediction(images);

    return Predictions(
      observationID: observationID,
      predictions: _makePredictions(results, localSpecies),
      dateCreated: DateTime.now().toUtc(),
      inferred: null,
      predictionType: PredictionType.offline,
    );
  }
}
