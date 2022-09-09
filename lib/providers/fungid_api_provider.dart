import 'dart:developer';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:fungid_api/fungid_api.dart';
import 'package:fungid_flutter/domain.dart';

class FungidApiProvider {
  const FungidApiProvider(FungidApi api) : _fungidApi = api;

  final FungidApi _fungidApi;
  FungidApi get fungidApi => _fungidApi;
  ClassifierApi get classifierApi => _fungidApi.getClassifierApi();

  Future<Predictions> getPredictions(
    DateTime date,
    num lat,
    num lon,
    List<UserObservationImage> images,
  ) async {
    var files = images
        .map(
          (img) => MultipartFile.fromBytes(
            img.imageBytes,
            filename: 'images',
          ),
        )
        .toBuiltList();

    try {
      var result = await classifierApi.evaluateFullClassifierClassifierFullPut(
        date: date,
        lat: lat,
        lon: lon,
        images: files,
      );

      if (result.statusCode == 200) {
        var data = result.data;
        List<Prediction> preds = [];

        if (data != null) {
          for (var pred in data.entries) {
            preds.add(Prediction(
              species: pred.key,
              probability: pred.value.toDouble(),
            ));

            if (preds.length > 100) {
              break;
            }
          }
        }

        return Predictions(
          dateCreated: DateTime.now().toUtc(),
          predictions: preds,
        );
      } else {
        log(result.toString());
        throw Exception(['Error getting predictions', result]);
      }
    } on DioError catch (e) {
      throw Exception(['Error getting predictions', e]);
    }
  }
}
