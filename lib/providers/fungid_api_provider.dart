import 'dart:developer';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fungid_api/fungid_api.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/utils/images.dart';

class FungidApiProvider {
  const FungidApiProvider(FungidApi api) : _fungidApi = api;

  final FungidApi _fungidApi;
  FungidApi get fungidApi => _fungidApi;
  ClassifierApi get classifierApi => _fungidApi.getClassifierApi();

  Uint8List prepareImage(UserObservationImage image) {
    return resizeFromFile(image.filename, 1000)!.getBytes();
  }

  Iterable<Uint8List> prepareImages(List<UserObservationImage> images) {
    return images.map(prepareImage);
  }

  Future<Predictions> getPredictions(
    String observationID,
    DateTime date,
    num lat,
    num lon,
    List<UserObservationImage> images,
  ) async {
    // var prepped = prepareImages(images);
    // var files = await Future.wait(prepped.map(
    //   (img) async => MultipartFile.fromBytes(
    //     img,
    //     filename: 'images',
    //   ),
    // ));

    var files = await Future.wait(images.map(
      (img) async => MultipartFile.fromFile(
        img.filename,
        filename: 'images',
      ),
    ));

    var result = await classifierApi.evaluateFullClassifierClassifierFullPut(
      date: date,
      lat: lat,
      lon: lon,
      images: BuiltList(files),
    );

    if (result.statusCode == 200) {
      var data = result.data;

      if (data != null) {
        return Predictions.fromApi(data, observationID);
      } else {
        throw Exception('No data returned');
      }
    } else {
      log(result.toString());
      throw Exception(['Error getting predictions', result]);
    }
  }
}
