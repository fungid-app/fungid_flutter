//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:fungid_api/src/date_serializer.dart';
import 'package:fungid_api/src/model/date.dart';

import 'package:fungid_api/src/model/basic_prediction.dart';
import 'package:fungid_api/src/model/classifier_version.dart';
import 'package:fungid_api/src/model/full_prediction.dart';
import 'package:fungid_api/src/model/full_predictions.dart';
import 'package:fungid_api/src/model/gbif_observation.dart';
import 'package:fungid_api/src/model/gbif_observation_image.dart';
import 'package:fungid_api/src/model/http_validation_error.dart';
import 'package:fungid_api/src/model/inferred_data.dart';
import 'package:fungid_api/src/model/location_inner.dart';
import 'package:fungid_api/src/model/page_basic_prediction.dart';
import 'package:fungid_api/src/model/page_gbif_observation.dart';
import 'package:fungid_api/src/model/page_gbif_observation_image.dart';
import 'package:fungid_api/src/model/page_species.dart';
import 'package:fungid_api/src/model/species.dart';
import 'package:fungid_api/src/model/validation_error.dart';

part 'serializers.g.dart';

@SerializersFor([
  BasicPrediction,
  ClassifierVersion,
  FullPrediction,
  FullPredictions,
  GbifObservation,
  GbifObservationImage,
  HTTPValidationError,
  InferredData,
  LocationInner,
  PageBasicPrediction,
  PageGbifObservation,
  PageGbifObservationImage,
  PageSpecies,
  Species,
  ValidationError,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltMap, [FullType(String), FullType(num)]),
        () => MapBuilder<String, num>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(String)]),
        () => ListBuilder<String>(),
      )
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
