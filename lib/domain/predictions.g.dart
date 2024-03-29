// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predictions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InferredData _$InferredDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'InferredData',
      json,
      ($checkedConvert) {
        final val = InferredData(
          normalizedMonth: $checkedConvert('normalized_month', (v) => v as int),
          season: $checkedConvert('season', (v) => v as String),
          kg: $checkedConvert('kg', (v) => v as int),
          eluClass1: $checkedConvert('elu_class1', (v) => v as String?),
          eluClass2: $checkedConvert('elu_class2', (v) => v as String?),
          eluClass3: $checkedConvert('elu_class3', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'normalizedMonth': 'normalized_month',
        'eluClass1': 'elu_class1',
        'eluClass2': 'elu_class2',
        'eluClass3': 'elu_class3'
      },
    );

Map<String, dynamic> _$InferredDataToJson(InferredData instance) =>
    <String, dynamic>{
      'normalized_month': instance.normalizedMonth,
      'season': instance.season,
      'kg': instance.kg,
      'elu_class1': instance.eluClass1,
      'elu_class2': instance.eluClass2,
      'elu_class3': instance.eluClass3,
    };

Predictions _$PredictionsFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Predictions',
      json,
      ($checkedConvert) {
        final val = Predictions(
          observationID: $checkedConvert('observation_i_d', (v) => v as String),
          predictions: $checkedConvert(
              'predictions',
              (v) => (v as List<dynamic>)
                  .map((e) => Prediction.fromJson(e as Map<String, dynamic>))
                  .toList()),
          dateCreated: $checkedConvert(
              'date_created', (v) => DateTime.parse(v as String)),
          inferred: $checkedConvert(
              'inferred',
              (v) => v == null
                  ? null
                  : InferredData.fromJson(v as Map<String, dynamic>)),
          predictionType: $checkedConvert('prediction_type',
              (v) => $enumDecodeNullable(_$PredictionTypeEnumMap, v)),
          modelVersion: $checkedConvert('model_version', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'observationID': 'observation_i_d',
        'dateCreated': 'date_created',
        'predictionType': 'prediction_type',
        'modelVersion': 'model_version'
      },
    );

Map<String, dynamic> _$PredictionsToJson(Predictions instance) =>
    <String, dynamic>{
      'observation_i_d': instance.observationID,
      'predictions': instance.predictions,
      'date_created': instance.dateCreated.toIso8601String(),
      'inferred': instance.inferred,
      'prediction_type': _$PredictionTypeEnumMap[instance.predictionType],
      'model_version': instance.modelVersion,
    };

const _$PredictionTypeEnumMap = {
  PredictionType.online: 'online',
  PredictionType.offline: 'offline',
};

BasicPrediction _$BasicPredictionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BasicPrediction',
      json,
      ($checkedConvert) {
        final val = BasicPrediction(
          specieskey: $checkedConvert('specieskey', (v) => v as int),
          probability: $checkedConvert('probability', (v) => v as num),
        );
        return val;
      },
    );

Map<String, dynamic> _$BasicPredictionToJson(BasicPrediction instance) =>
    <String, dynamic>{
      'specieskey': instance.specieskey,
      'probability': instance.probability,
    };

LocalPrediction _$LocalPredictionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'LocalPrediction',
      json,
      ($checkedConvert) {
        final val = LocalPrediction(
          specieskey: $checkedConvert('specieskey', (v) => v),
          probability: $checkedConvert('probability', (v) => v),
          isLocal: $checkedConvert('is_local', (v) => v as bool),
          localProbability:
              $checkedConvert('local_probability', (v) => v as num),
        );
        return val;
      },
      fieldKeyMap: const {
        'isLocal': 'is_local',
        'localProbability': 'local_probability'
      },
    );

Map<String, dynamic> _$LocalPredictionToJson(LocalPrediction instance) =>
    <String, dynamic>{
      'specieskey': instance.specieskey,
      'probability': instance.probability,
      'is_local': instance.isLocal,
      'local_probability': instance.localProbability,
    };

Prediction _$PredictionFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Prediction',
      json,
      ($checkedConvert) {
        final val = Prediction(
          specieskey: $checkedConvert('specieskey', (v) => v),
          species: $checkedConvert('species', (v) => v as String),
          probability: $checkedConvert('probability', (v) => v),
          localProbability: $checkedConvert('local_probability', (v) => v),
          imageScore:
              $checkedConvert('image_score', (v) => (v as num?)?.toDouble()),
          tabScore:
              $checkedConvert('tab_score', (v) => (v as num?)?.toDouble()),
          localScore:
              $checkedConvert('local_score', (v) => (v as num?)?.toDouble()),
          isLocal: $checkedConvert('is_local', (v) => v),
        );
        return val;
      },
      fieldKeyMap: const {
        'localProbability': 'local_probability',
        'imageScore': 'image_score',
        'tabScore': 'tab_score',
        'localScore': 'local_score',
        'isLocal': 'is_local'
      },
    );

Map<String, dynamic> _$PredictionToJson(Prediction instance) =>
    <String, dynamic>{
      'specieskey': instance.specieskey,
      'probability': instance.probability,
      'is_local': instance.isLocal,
      'local_probability': instance.localProbability,
      'species': instance.species,
      'image_score': instance.imageScore,
      'local_score': instance.localScore,
      'tab_score': instance.tabScore,
    };
