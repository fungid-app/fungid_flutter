part of 'app_settings_bloc.dart';

abstract class AppSettingsEvent extends Equatable {
  const AppSettingsEvent();

  @override
  List<Object> get props => [];
}

class AppSettingsLoad extends AppSettingsEvent {}

class ToggleDarkMode extends AppSettingsEvent {}

class ToggleOfflineMode extends AppSettingsEvent {}
