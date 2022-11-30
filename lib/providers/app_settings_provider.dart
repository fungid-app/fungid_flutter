import 'dart:async';
import 'dart:convert';

import 'package:fungid_flutter/domain/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsSharedPrefProvider {
  AppSettingsSharedPrefProvider({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  final SharedPreferences _prefs;

  static const _settingsKey = 'settings_';

  String? _getValue(String key) => _prefs.getString(key);

  Future<void> _setValue(String key, String value) =>
      _prefs.setString(key, value);

  Future<void> saveSettings(AppSettings preds) async {
    await _setValue(
      _settingsKey,
      json.encode(preds),
    );
  }

  AppSettings getSettings() {
    final settingsJson = _getValue(_settingsKey);

    if (settingsJson != null) {
      return AppSettings.fromJson(
          json.decode(settingsJson) as Map<String, dynamic>);
    } else {
      return const AppSettings();
    }
  }
}
