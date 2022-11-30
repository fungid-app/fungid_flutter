import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'app_settings.g.dart';

@JsonSerializable()
class AppSettings extends Equatable {
  final bool? isDarkMode;
  final bool isOfflineModeActive;
  final String? languageCode;
  final bool showLocalNotifications;

  const AppSettings({
    this.isDarkMode,
    this.isOfflineModeActive = false,
    this.languageCode,
    this.showLocalNotifications = false,
  });

  @override
  List<Object?> get props => [
        isDarkMode,
      ];

  static List<AppSettings> observations = [];
  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$AppSettingsToJson(this);

  AppSettings copyWith({
    bool? isDarkMode,
    bool? isOfflineModeActive,
    String? languageCode,
    bool? showLocalNotifications,
  }) {
    return AppSettings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isOfflineModeActive: isOfflineModeActive ?? this.isOfflineModeActive,
      languageCode: languageCode ?? this.languageCode,
      showLocalNotifications:
          showLocalNotifications ?? this.showLocalNotifications,
    );
  }
}
