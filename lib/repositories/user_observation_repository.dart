import 'dart:convert';

import 'package:fungid_flutter/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserObservationsSharedPrefProvider {
  UserObservationsSharedPrefProvider({required SharedPreferences prefs})
      : _prefs = prefs;

  static const kObsevationPrefix = 'observation_';
  static const _kObservationList = 'observations';
  final SharedPreferences _prefs;

  List<String> _getObservationList() {
    return _prefs.getStringList(_kObservationList) ?? [];
  }

  Future<bool> _saveObservationList(List<String> observations) async {
    return _prefs.setStringList(_kObservationList, observations);
  }

  Future<bool> _addToObservationList(String id) async {
    final observations = _getObservationList();

    if (!observations.contains(id)) {
      observations.add(id);
      return _saveObservationList(observations);
    }

    return true;
  }

  Future<bool> _removeFromObservationList(String id) async {
    final observations = _getObservationList();
    observations.remove(id);
    return _saveObservationList(observations);
  }

  Future<bool> _saveObservation(UserObservation obs) async {
    final key = '$kObsevationPrefix${obs.id}';
    final json = obs.toJson();

    _addToObservationList(obs.id);

    return _prefs.setString(key, json.toString());
  }

  Future<UserObservation?> getObservation(String id) async {
    final key = '$kObsevationPrefix$id';
    final jsonString = _prefs.getString(key);

    if (jsonString == null) return null;

    var json = jsonDecode(jsonString);

    return UserObservation.fromJson(json);
  }

  List<UserObservation> getAllObservations() {
    final observations = _getObservationList();

    return observations
        .map((id) => getObservation(id))
        .whereType<UserObservation>()
        .toList();
  }

  Future<bool> saveObservations(List<UserObservation> obs) async {
    var results = await Future.wait(obs.map((ob) => _saveObservation(ob)));

    return results.every((r) => r);
  }

  Future<bool> removeObservation(String id) async {
    final key = '$kObsevationPrefix$id';

    var result1 = await _prefs.remove(key);
    var result2 = await _removeFromObservationList(id);
    return result1 && result2;
  }
}

class UserObservationsRepository {
  UserObservationsRepository(this.provider);

  final UserObservationsSharedPrefProvider provider;

  List<UserObservation> getAllObservations() {
    return provider.getAllObservations();
  }

  Future<bool> saveObservations(List<UserObservation> obs) async {
    return provider.saveObservations(obs);
  }

  Future<bool> clearObservations() async {
    var observations = provider.getAllObservations();
    var results = await Future.wait(
        observations.map((obs) => provider.removeObservation(obs.id)));

    return results.every((e) => e);
  }
}
