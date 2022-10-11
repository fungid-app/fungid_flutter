import 'package:equatable/equatable.dart';
import 'package:fungid_api/fungid_api.dart' as api;
import 'package:json_annotation/json_annotation.dart';

part 'predictions.g.dart';

const maxImages = 10;
const maxImageSize = 1000;

@JsonSerializable()
class InferredData extends Equatable {
  final int normalizedMonth;
  final String season;
  final int kg;
  final String? eluClass1;
  final String? eluClass2;
  final String? eluClass3;

  const InferredData({
    required this.normalizedMonth,
    required this.season,
    required this.kg,
    this.eluClass1,
    this.eluClass2,
    this.eluClass3,
  });

  @override
  List<Object?> get props => [
        normalizedMonth,
        season,
        kg,
        eluClass1,
        eluClass2,
        eluClass3,
      ];

  factory InferredData.fromApi(api.InferredData data) {
    return InferredData(
      normalizedMonth: data.normalizedMonth,
      season: data.season,
      kg: data.kg,
      eluClass1: data.eluClass1,
      eluClass2: data.eluClass2,
      eluClass3: data.eluClass3,
    );
  }

  factory InferredData.fromJson(Map<String, dynamic> json) =>
      _$InferredDataFromJson(json);

  Map<String, dynamic> toJson() => _$InferredDataToJson(this);
}

enum PredictionType {
  online,
  offline,
}

@JsonSerializable()
class Predictions extends Equatable {
  final String observationID;
  final List<Prediction> predictions;
  final DateTime dateCreated;
  final InferredData? inferred;
  final PredictionType? predictionType;
  final String modelVersion;

  const Predictions({
    required this.observationID,
    required this.predictions,
    required this.dateCreated,
    required this.inferred,
    required this.predictionType,
    required this.modelVersion,
  });

  @override
  List<Object?> get props => [predictions, dateCreated];

  factory Predictions.fromJson(Map<String, dynamic> json) =>
      _$PredictionsFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionsToJson(this);

  factory Predictions.fromApi(
    api.FullPredictions preds,
    String observationID,
    String version,
  ) {
    return Predictions(
      observationID: observationID,
      predictions: preds.predictions
          .map((e) => Prediction.fromApiPrediction(e))
          .toList(),
      dateCreated: DateTime.now().toUtc(),
      inferred: InferredData.fromApi(preds.inferred),
      predictionType: PredictionType.online,
      modelVersion: version,
    );
  }
}

@JsonSerializable()
class Prediction extends Equatable {
  final String species;
  final double probability;
  final double localProbability;
  final double? imageScore;
  final double? tabScore;
  final double? localScore;
  final bool? isLocal;

  const Prediction({
    required this.species,
    required this.probability,
    required this.localProbability,
    required this.imageScore,
    required this.tabScore,
    required this.localScore,
    required this.isLocal,
  });

  String displayProbabilty() {
    return "${(probability * 100).toStringAsFixed(4)}%";
  }

  @override
  List<Object?> get props => [species, probability];

  factory Prediction.fromApiPrediction(api.FullPrediction prediction) =>
      Prediction(
        species: prediction.species,
        probability: prediction.probability.toDouble(),
        localProbability: prediction.localProbability.toDouble(),
        imageScore: prediction.imageScore.toDouble(),
        tabScore: prediction.tabScore.toDouble(),
        localScore: prediction.localScore.toDouble(),
        isLocal: prediction.isLocal,
      );

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionToJson(this);
}
