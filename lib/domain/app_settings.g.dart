// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => $checkedCreate(
      'AppSettings',
      json,
      ($checkedConvert) {
        final val = AppSettings(
          isDarkMode: $checkedConvert('is_dark_mode', (v) => v as bool?),
          isOfflineModeActive: $checkedConvert(
              'is_offline_mode_active', (v) => v as bool? ?? false),
          languageCode: $checkedConvert('language_code', (v) => v as String?),
          showLocalNotifications: $checkedConvert(
              'show_local_notifications', (v) => v as bool? ?? false),
        );
        return val;
      },
      fieldKeyMap: const {
        'isDarkMode': 'is_dark_mode',
        'isOfflineModeActive': 'is_offline_mode_active',
        'languageCode': 'language_code',
        'showLocalNotifications': 'show_local_notifications'
      },
    );

Map<String, dynamic> _$AppSettingsToJson(AppSettings instance) =>
    <String, dynamic>{
      'is_dark_mode': instance.isDarkMode,
      'is_offline_mode_active': instance.isOfflineModeActive,
      'language_code': instance.languageCode,
      'show_local_notifications': instance.showLocalNotifications,
    };
