import 'dart:developer';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:fungid_api/fungid_api.dart';
import 'package:fungid_flutter/utils/images.dart';
import 'package:path_provider/path_provider.dart';

class OnlinePredictionsProvider {
  final FungidApi fungidApi;
  ClassifierApi? classifierApi;
  String? currentVersion;
  int? classifierImgSize;

  OnlinePredictionsProvider._({
    required this.fungidApi,
  });

  static Future<OnlinePredictionsProvider> create(
    FungidApi fungidApi,
  ) async {
    var provider = OnlinePredictionsProvider._(
      fungidApi: fungidApi,
    );

    await provider._init();

    return provider;
  }

  Future<void> _init() async {
    classifierApi = fungidApi.getClassifierApi();
    _ensureCurrentVersion();
  }

  Future<void> _ensureCurrentVersion() async {
    if (currentVersion == null) {
      try {
        var result = await classifierApi!.getVersionClassifierVersionGet();

        if (result.statusCode == 200) {
          var data = result.data;

          if (data != null) {
            currentVersion = data.version;
            classifierImgSize = data.imageSize;
          } else {
            throw Exception('No data returned');
          }
        } else {
          log('Error getting version: ${result.statusCode}');
        }
      } catch (e) {
        log('Error getting version: $e');
      }
    }
  }

  Future<Iterable<MultipartFile>> _buildImageFiles(
      Iterable<String> paths, Directory appDir) async {
    var prepped = await prepareImageFiles(paths, appDir, classifierImgSize!);

    return await Future.wait(prepped.map(
      (path) async => await MultipartFile.fromFile(
        path,
        filename: 'images',
      ),
    ));
  }

  Future<FullPredictions> getPredictions(
    String observationID,
    DateTime date,
    num lat,
    num lon,
    List<String> imagePaths,
  ) async {
    await _ensureCurrentVersion();

    final appDir = await getTemporaryDirectory();
    var files = await _buildImageFiles(imagePaths, appDir);

    var result = await classifierApi!.evaluateFullClassifierClassifierFullPut(
      date: date,
      lat: lat,
      lon: lon,
      images: BuiltList(files),
    );

    if (result.statusCode == 200) {
      var data = result.data;

      if (data != null) {
        return data;
      } else {
        throw Exception('No data returned');
      }
    } else {
      log(result.toString());
      throw Exception(['Error getting predictions', result]);
    }
  }

  Future<List<BasicPrediction>> getSeasonalSpecies({
    required num lat,
    required num lon,
    Date? date,
    int? size,
    int? page,
  }) async {
    var result = await classifierApi!.getSeasonalClassifierSeasonalGet(
      date: date,
      lat: lat,
      lon: lon,
      size: size,
    );

    if (result.statusCode == 200) {
      var data = result.data;

      if (data != null) {
        return data.items.toList();
      } else {
        throw Exception('No data returned');
      }
    } else {
      log(result.toString());
      throw Exception(['Error getting predictions', result]);
    }
  }
}
