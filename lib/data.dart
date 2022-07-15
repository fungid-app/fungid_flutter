import 'dart:convert';

import 'package:fungid_flutter/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserObservationsSharedPrefProvider {
  static const kObsevationPrefix = 'observation_';
  static const _kObservationList = 'observations';

  Future<List<String>> _getObservationList(SharedPreferences prefs) async {
    return prefs.getStringList(_kObservationList) ?? [];
  }

  Future<bool> _saveObservationList(
      List<String> observations, SharedPreferences prefs) async {
    return prefs.setStringList(_kObservationList, observations);
  }

  Future<bool> _addToObservationList(String id, SharedPreferences prefs) async {
    final observations = await _getObservationList(prefs);

    if (!observations.contains(id)) {
      observations.add(id);
      return _saveObservationList(observations, prefs);
    }

    return true;
  }

  Future<bool> _removeFromObservationList(
      String id, SharedPreferences prefs) async {
    final observations = await _getObservationList(prefs);
    observations.remove(id);
    return _saveObservationList(observations, prefs);
  }

  Future<bool> _saveObservation(
      UserObservation obs, SharedPreferences prefs) async {
    final key = '$kObsevationPrefix${obs.id}';
    final json = obs.toJson();

    _addToObservationList(obs.id, prefs);

    return prefs.setString(key, json.toString());
  }

  Future<UserObservation?> getObservation(String id,
      [SharedPreferences? prefs]) async {
    final localPrefs = prefs ?? await SharedPreferences.getInstance();
    final key = '$kObsevationPrefix$id';
    final jsonString = localPrefs.getString(key);

    if (jsonString == null) return null;

    var json = jsonDecode(jsonString);

    return UserObservation.fromJson(json);
  }

  Future<List<UserObservation>> getAllObservations() async {
    final localPrefs = await SharedPreferences.getInstance();

    final observations = await _getObservationList(localPrefs);

    return await Future.wait(
            observations.map((id) => getObservation(id, localPrefs)))
        .then((obs) => obs.whereType<UserObservation>().toList());
  }

  Future<bool> saveObservations(List<UserObservation> obs) async {
    final localPrefs = await SharedPreferences.getInstance();

    var results =
        await Future.wait(obs.map((ob) => _saveObservation(ob, localPrefs)));

    return results.every((r) => r);
  }

  Future<bool> removeObservation(String id, [SharedPreferences? prefs]) async {
    final localPrefs = prefs ?? await SharedPreferences.getInstance();
    final key = '$kObsevationPrefix$id';

    var result1 = await localPrefs.remove(key);
    var result2 = await _removeFromObservationList(id, localPrefs);
    return result1 && result2;
  }
}

class UserObservationsRepository {
  UserObservationsRepository(this.provider);

  final UserObservationsSharedPrefProvider provider;

  Future<List<UserObservation>> getAllObservations() async {
    return provider.getAllObservations();
  }

  Future<bool> saveObservations(List<UserObservation> obs) async {
    return provider.saveObservations(obs);
  }

  Future<bool> clearObservations() async {
    var observations = await provider.getAllObservations();
    var results = await Future.wait(
        observations.map((obs) => provider.removeObservation(obs.id)));

    return results.every((e) => e);
  }
}
