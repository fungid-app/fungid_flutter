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
          location: $checkedConvert('location',
              (v) => ObservationLocation.fromJson(v as Map<String, dynamic>)),
          images: $checkedConvert(
              'images',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      UserObservationImage.fromJson(e as Map<String, dynamic>))
                  .toList()),
          id: $checkedConvert('id', (v) => v as String),
          dateCreated: $checkedConvert(
              'date_created', (v) => DateTime.parse(v as String)),
          observationDate: $checkedConvert(
              'observation_date', (v) => DateTime.parse(v as String)),
          predictions: $checkedConvert(
              'predictions',
              (v) => v == null
                  ? null
                  : Predictions.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'dateCreated': 'date_created',
        'observationDate': 'observation_date'
      },
    );

Map<String, dynamic> _$UserObservationToJson(UserObservation instance) =>
    <String, dynamic>{
      'location': instance.location,
      'id': instance.id,
      'date_created': instance.dateCreated.toIso8601String(),
      'observation_date': instance.observationDate.toIso8601String(),
      'images': instance.images,
      'predictions': instance.predictions,
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
      'predictions': instance.predictions,
      'date_created': instance.dateCreated.toIso8601String(),
    };

ObservationLocation _$ObservationLocationFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ObservationLocation',
      json,
      ($checkedConvert) {
        final val = ObservationLocation(
          lat: $checkedConvert('lat', (v) => (v as num).toDouble()),
          lng: $checkedConvert('lng', (v) => (v as num).toDouble()),
          placeName: $checkedConvert('place_name', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'placeName': 'place_name'},
    );

Map<String, dynamic> _$ObservationLocationToJson(
        ObservationLocation instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'place_name': instance.placeName,
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

UserObservationImage _$UserObservationImageFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'UserObservationImage',
      json,
      ($checkedConvert) {
        final val = UserObservationImage(
          filename: $checkedConvert('filename', (v) => v as String),
          id: $checkedConvert('id', (v) => v as String),
          dateCreated: $checkedConvert('date_created',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {'dateCreated': 'date_created'},
    );

Map<String, dynamic> _$UserObservationImageToJson(
        UserObservationImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filename': instance.filename,
      'date_created': instance.dateCreated.toIso8601String(),
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
