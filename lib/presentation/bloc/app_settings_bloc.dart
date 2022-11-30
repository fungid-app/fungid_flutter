import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/domain/app_settings.dart';
import 'package:fungid_flutter/repositories/app_settings_repository.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc({
    required this.settingsRepository,
    required this.isSystemThemeDark,
  }) : super(AppSettingsInitial()) {
    on<AppSettingsLoad>(_onAppSettingsLoad);
    on<ToggleDarkMode>(_onToggleDarkMode);
    on<ToggleOfflineMode>(_onToggleOfflineMode);
  }
  final bool isSystemThemeDark;
  final AppSettingsRepository settingsRepository;

  void _onAppSettingsLoad(
    AppSettingsLoad event,
    Emitter<AppSettingsState> emit,
  ) {
    try {
      final settings = settingsRepository.getSettings();
      emit(AppSettingsLoaded(
        isDarkMode: settings.isDarkMode,
        isOfflineModeActive: settings.isOfflineModeActive,
        effectiveIsDarkMode: settings.isDarkMode ?? isSystemThemeDark,
      ));
    } catch (e) {
      emit(AppSettingsError(e.toString()));
    }
  }

  void _onToggleDarkMode(
    ToggleDarkMode event,
    Emitter<AppSettingsState> emit,
  ) {
    if (state is AppSettingsLoaded) {
      final currentState = state as AppSettingsLoaded;

      final newState = currentState.copyWith(
        isDarkMode: !currentState.effectiveIsDarkMode,
        effectiveIsDarkMode: !currentState.effectiveIsDarkMode,
      );

      _saveSettings(newState, emit);
    }
  }

  void _onToggleOfflineMode(
    ToggleOfflineMode event,
    Emitter<AppSettingsState> emit,
  ) {
    if (state is AppSettingsLoaded) {
      final currentState = state as AppSettingsLoaded;

      final newState = currentState.copyWith(
        isOfflineModeActive: !currentState.isOfflineModeActive,
      );

      _saveSettings(newState, emit);
    }
  }

  void _saveSettings(
    AppSettingsLoaded state,
    Emitter<AppSettingsState> emit,
  ) {
    try {
      settingsRepository.saveSettings(
        AppSettings(
          isDarkMode: state.isDarkMode,
          isOfflineModeActive: state.isOfflineModeActive,
        ),
      );
      emit(state);
    } catch (e) {
      emit(AppSettingsError(e.toString()));
    }
  }
}
