import 'dart:async';
import 'dart:convert';

import 'package:fungid_flutter/domain/predictions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedPredictionsSharedPrefProvider {
  SavedPredictionsSharedPrefProvider({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  final SharedPreferences _prefs;

  static const _observationPredictionsKey = 'predictions_';
  static const _seasonalPredictionsKey = 'seasonal_';

  String? _getValue(String key) => _prefs.getString(key);

  Future<void> _setValue(String key, String value) =>
      _prefs.setString(key, value);

  Future<void> saveObservationPredictions(Predictions preds) {
    return _setValue(
        _observationPredictionsKey + preds.observationID, json.encode(preds));
  }

  Predictions? getObservationPredictions(String id) {
    final predsJson = _getValue(_observationPredictionsKey + id);

    if (predsJson != null) {
      return Predictions.fromJson(
          json.decode(predsJson) as Map<String, dynamic>);
    }

    return null;
  }

  Future<void> deleteObservationPredictions(String id) async {
    await _prefs.remove(_observationPredictionsKey + id);
  }

  String _buildSeasonalPredictionsKey(DateTime date, num lat, num lon) {
    return '$_seasonalPredictionsKey-${date.month}-${lat.round()}${lon.round()}';
  }

  List<BasicPrediction>? getSeasonalPredictions(
      DateTime date, num lat, num lon) {
    final predsJson = _getValue(_buildSeasonalPredictionsKey(date, lat, lon));

    return decodeBasicPredictionList(predsJson);
  }

  List<BasicPrediction>? decodeBasicPredictionList(String? predsJson) {
    if (predsJson != null) {
      return List<Map<dynamic, dynamic>>.from(json.decode(predsJson) as List)
          .map((jsonMap) =>
              BasicPrediction.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
    }

    return null;
  }

  Future<void> saveSeasonalPredictions(
    DateTime date,
    num lat,
    num lon,
    List<BasicPrediction> preds,
  ) {
    return _setValue(
      _buildSeasonalPredictionsKey(date, lat, lon),
      json.encode(preds),
    );
  }
}
