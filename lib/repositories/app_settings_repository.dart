import 'package:fungid_flutter/domain/app_settings.dart';
import 'package:fungid_flutter/providers/app_settings_provider.dart';

class AppSettingsRepository {
  AppSettingsRepository({
    required this.appSettingsProvider,
  });
  AppSettingsSharedPrefProvider appSettingsProvider;

  AppSettings getSettings() {
    return appSettingsProvider.getSettings();
  }

  Future<void> saveSettings(AppSettings settings) async {
    await appSettingsProvider.saveSettings(settings);
  }
}
