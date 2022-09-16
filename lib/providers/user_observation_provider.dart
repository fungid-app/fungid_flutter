import 'dart:async';
import 'dart:convert';

import 'package:fungid_flutter/domain/observations.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserObservationsSharedPrefProvider {
  UserObservationsSharedPrefProvider({required SharedPreferences prefs})
      : _prefs = prefs {
    _init();
  }

  final SharedPreferences _prefs;

  final _observationStreamController =
      BehaviorSubject<List<UserObservation>>.seeded(const []);

  static const _obsevationCollectionsKey = '_observation_collection_key';

  String? _getValue(String key) => _prefs.getString(key);
  Future<void> _setValue(String key, String value) =>
      _prefs.setString(key, value);

  void _init() {
    final obsJson = _getValue(_obsevationCollectionsKey);
    if (obsJson != null) {
      final obs = List<Map<dynamic, dynamic>>.from(
        json.decode(obsJson) as List,
      )
          .map((jsonMap) =>
              UserObservation.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _observationStreamController.add(obs);
    } else {
      _observationStreamController.add([]);
    }
  }

  Stream<List<UserObservation>> getObservations() =>
      _observationStreamController.asBroadcastStream();

  Future<void> saveObservation(UserObservation obs) {
    final observations = [..._observationStreamController.value];
    final index = observations.indexWhere((o) => o.id == obs.id);
    if (index >= 0) {
      observations[index] = obs;
    } else {
      observations.insert(0, obs);
    }

    _observationStreamController.add(observations);
    return _setValue(_obsevationCollectionsKey, json.encode(observations));
  }

  UserObservation? getObservation(String id) {
    final observations = [..._observationStreamController.value];
    final index = observations.indexWhere((o) => o.id == id);
    if (index >= 0) {
      return observations[index];
    } else {
      return null;
    }
  }

  Future<void> deleteObservation(String id) async {
    final observations = [..._observationStreamController.value];
    final index = observations.indexWhere((o) => o.id == id);
    if (index == -1) {
      throw Exception('Observation not found');
    } else {
      observations.removeAt(index);
      _observationStreamController.add(observations);
      return _setValue(_obsevationCollectionsKey, json.encode(observations));
    }
  }

  Future<bool> clear() async {
    _observationStreamController.add([]);
    return _prefs.clear();
  }
}
