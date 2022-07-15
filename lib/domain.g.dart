// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserObservation _$UserObservationFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UserObservation',
      json,
      ($checkedConvert) {
        final val = UserObservation(
          lat: $checkedConvert('lat', (v) => (v as num).toDouble()),
          lng: $checkedConvert('lng', (v) => (v as num).toDouble()),
          dateCreated: $checkedConvert(
              'date_created', (v) => DateTime.parse(v as String)),
          images: $checkedConvert(
              'images',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      UserObservationImage.fromJson(e as Map<String, dynamic>))
                  .toList()),
          id: $checkedConvert('id', (v) => v as String),
          lastUpdated: $checkedConvert(
              'last_updated', (v) => DateTime.parse(v as String)),
        );
        $checkedConvert(
            'predictions',
            (v) => val.predictions = v == null
                ? null
                : Predictions.fromJson(v as Map<String, dynamic>));
        return val;
      },
      fieldKeyMap: const {
        'dateCreated': 'date_created',
        'lastUpdated': 'last_updated'
      },
    );

Map<String, dynamic> _$UserObservationToJson(UserObservation instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'id': instance.id,
      'date_created': instance.dateCreated.toIso8601String(),
      'last_updated': instance.lastUpdated.toIso8601String(),
      'images': instance.images.map((e) => e.toJson()).toList(),
      'predictions': instance.predictions?.toJson(),
    };

Predictions _$PredictionsFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Predictions',
      json,
      ($checkedConvert) {
        final val = Predictions(
          predictions: $checkedConvert(
              'predictions',
              (v) => (v as List<dynamic>)
                  .map((e) => Prediction.fromJson(e as Map<String, dynamic>))
                  .toList()),
          dateCreated: $checkedConvert(
              'date_created', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {'dateCreated': 'date_created'},
    );

Map<String, dynamic> _$PredictionsToJson(Predictions instance) =>
    <String, dynamic>{
      'predictions': instance.predictions.map((e) => e.toJson()).toList(),
      'date_created': instance.dateCreated.toIso8601String(),
    };

Prediction _$PredictionFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Prediction',
      json,
      ($checkedConvert) {
        final val = Prediction(
          species: $checkedConvert('species', (v) => v as String),
          probability:
              $checkedConvert('probability', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$PredictionToJson(Prediction instance) =>
    <String, dynamic>{
      'species': instance.species,
      'probability': instance.probability,
    };

Species _$SpeciesFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Species',
      json,
      ($checkedConvert) {
        final val = Species(
          id: $checkedConvert('id', (v) => v as String),
          phylum: $checkedConvert('phylum', (v) => v as String),
          classname: $checkedConvert('classname', (v) => v as String),
          order: $checkedConvert('order', (v) => v as String),
          family: $checkedConvert('family', (v) => v as String),
          genus: $checkedConvert('genus', (v) => v as String),
          species: $checkedConvert('species', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          includedInClassifier:
              $checkedConvert('included_in_classifier', (v) => v as bool),
          numberOfObservations:
              $checkedConvert('number_of_observations', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {
        'includedInClassifier': 'included_in_classifier',
        'numberOfObservations': 'number_of_observations'
      },
    );

Map<String, dynamic> _$SpeciesToJson(Species instance) => <String, dynamic>{
      'id': instance.id,
      'phylum': instance.phylum,
      'classname': instance.classname,
      'order': instance.order,
      'family': instance.family,
      'genus': instance.genus,
      'species': instance.species,
      'description': instance.description,
      'included_in_classifier': instance.includedInClassifier,
      'number_of_observations': instance.numberOfObservations,
    };
