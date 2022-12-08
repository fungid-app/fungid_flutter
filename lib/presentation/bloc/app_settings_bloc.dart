import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fungid_flutter/domain/app_settings.dart';
import 'package:fungid_flutter/repositories/app_settings_repository.dart';
import 'package:fungid_flutter/repositories/predictions_repository.dart';
import 'package:fungid_flutter/utils/offline_predictions_downloader.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc({
    required this.settingsRepository,
    required this.isSystemThemeDark,
    required this.predictionsRepository,
  }) : super(AppSettingsInitial()) {
    on<AppSettingsLoad>(_onAppSettingsLoad);
    on<ToggleDarkMode>(_onToggleDarkMode);
    on<ToggleOfflineMode>(_onToggleOfflineMode);
  }
  final bool isSystemThemeDark;
  final AppSettingsRepository settingsRepository;
  final PredictionsRepository predictionsRepository;

  Future<void> _onAppSettingsLoad(
    AppSettingsLoad event,
    Emitter<AppSettingsState> emit,
  ) async {
    try {
      final settings = settingsRepository.getSettings();
      var currentState = AppSettingsLoaded(
        isDarkMode: settings.isDarkMode,
        isOfflineModeActive: settings.isOfflineModeActive,
        effectiveIsDarkMode: settings.isDarkMode ?? isSystemThemeDark,
      );
      emit(currentState);

      if (settings.isOfflineModeActive) {
        await loadOfflineModel(emit, currentState);
      }
    } catch (e) {
      rethrow;
    }
  }

  void _onToggleDarkMode(
    ToggleDarkMode event,
    Emitter<AppSettingsState> emit,
  ) {
    if (state is AppSettingsLoaded) {
      final currentState = state as AppSettingsLoaded;

      emit(currentState.copyWith(
        isDarkMode: !currentState.effectiveIsDarkMode,
        effectiveIsDarkMode: !currentState.effectiveIsDarkMode,
      ));

      _saveSettings(
        !currentState.effectiveIsDarkMode,
        currentState.isOfflineModeActive,
      );
    }
  }

  Future<void> _onToggleOfflineMode(
    ToggleOfflineMode event,
    Emitter<AppSettingsState> emit,
  ) async {
    if (state is AppSettingsLoaded) {
      final currentState = state as AppSettingsLoaded;
      var offlineActive = !currentState.isOfflineModeActive;

      _saveSettings(currentState.isDarkMode, offlineActive);

      if (offlineActive) {
        await loadOfflineModel(
          emit,
          currentState,
        );
      } else {
        await predictionsRepository.disableOfflinePredictions();
        emit(
          AppSettingsLoaded(
            isDarkMode: currentState.isDarkMode,
            isOfflineModeActive: offlineActive,
            effectiveIsDarkMode: currentState.effectiveIsDarkMode,
          ),
        );
      }
    }
  }

  Future<void> loadOfflineModel(
    Emitter<AppSettingsState> emit,
    AppSettingsLoaded currentState,
  ) async {
    await emit.forEach<OfflinePredictionsDownloadStatus>(
        predictionsRepository.enableOfflinePredictions(), onData: (status) {
      if (status.status == OfflinePredictionsDownloadStatusEnum.success) {
        _saveSettings(currentState.isDarkMode, true);

        return AppSettingsLoadedOffline(
          isDarkMode: currentState.isDarkMode,
          isOfflineModeActive: true,
          effectiveIsDarkMode: currentState.effectiveIsDarkMode,
          version: predictionsRepository.offlineModelVersion,
        );
      } else if (status.status == OfflinePredictionsDownloadStatusEnum.failed) {
        _saveSettings(currentState.isDarkMode, false);

        return AppSettingsErrorOffline(
          isDarkMode: currentState.isDarkMode,
          isOfflineModeActive: false,
          effectiveIsDarkMode: currentState.effectiveIsDarkMode,
          message: status.message ?? "Unknown error",
        );
      } else if (status.status ==
          OfflinePredictionsDownloadStatusEnum.downloading) {
        return AppSettingsLoadingOffline(
          isDarkMode: currentState.isDarkMode,
          isOfflineModeActive: true,
          effectiveIsDarkMode: currentState.effectiveIsDarkMode,
          progress: double.parse(status.message ?? "0"),
        );
      }

      return currentState;
    });
  }

  void _saveSettings(
    bool? isDarkMode,
    bool isOfflineModeActive,
  ) {
    settingsRepository.saveSettings(
      AppSettings(
        isDarkMode: isDarkMode,
        isOfflineModeActive: isOfflineModeActive,
      ),
    );
  }
}
