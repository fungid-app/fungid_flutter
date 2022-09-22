// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observations.dart';

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
          lastUpdated: $checkedConvert('last_updated',
              (v) => v == null ? null : DateTime.parse(v as String)),
          notes: $checkedConvert('notes', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'dateCreated': 'date_created',
        'observationDate': 'observation_date',
        'lastUpdated': 'last_updated'
      },
    );

Map<String, dynamic> _$UserObservationToJson(UserObservation instance) =>
    <String, dynamic>{
      'location': instance.location,
      'id': instance.id,
      'date_created': instance.dateCreated.toIso8601String(),
      'observation_date': instance.observationDate.toIso8601String(),
      'last_updated': instance.lastUpdated?.toIso8601String(),
      'notes': instance.notes,
      'images': instance.images,
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
