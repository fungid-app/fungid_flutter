import 'dart:async';
import 'dart:convert';

import 'package:fungid_flutter/domain/predictions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PredictionsSharedPrefProvider {
  PredictionsSharedPrefProvider({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  final SharedPreferences _prefs;

  static const _predictionsKey = 'predictions_';

  String? _getValue(String key) => _prefs.getString(key);

  Future<void> _setValue(String key, String value) =>
      _prefs.setString(key, value);

  Future<void> savePredictions(Predictions preds) {
    return _setValue(_predictionsKey + preds.observationID, json.encode(preds));
  }

  Predictions? getPredictions(String id) {
    final predsJson = _getValue(_predictionsKey + id);

    if (predsJson != null) {
      return Predictions.fromJson(
          json.decode(predsJson) as Map<String, dynamic>);
    }

    return null;
  }

  Future<void> deletePredictions(String id) async {
    await _prefs.remove(_predictionsKey + id);
  }
}
