part of 'app_settings_bloc.dart';

abstract class AppSettingsState extends Equatable {
  const AppSettingsState();

  @override
  List<Object> get props => [];
}

class AppSettingsInitial extends AppSettingsState {}

class AppSettingsLoading extends AppSettingsState {}

class AppSettingsLoaded extends AppSettingsState {
  final bool? isDarkMode;
  final bool effectiveIsDarkMode;
  final bool isOfflineModeActive;

  const AppSettingsLoaded({
    this.isDarkMode,
    required this.isOfflineModeActive,
    required this.effectiveIsDarkMode,
  });

  @override
  List<Object> get props => [
        isDarkMode ?? "",
        isOfflineModeActive,
        effectiveIsDarkMode,
      ];

  AppSettingsLoaded copyWith({
    bool? isDarkMode,
    bool? isOfflineModeActive,
    bool? effectiveIsDarkMode,
  }) {
    return AppSettingsLoaded(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isOfflineModeActive: isOfflineModeActive ?? this.isOfflineModeActive,
      effectiveIsDarkMode: effectiveIsDarkMode ?? this.effectiveIsDarkMode,
    );
  }
}

class AppSettingsError extends AppSettingsState {
  final String message;

  const AppSettingsError(this.message);

  @override
  List<Object> get props => [message];
}

class AppSettingsLoadingOffline extends AppSettingsLoaded {
  const AppSettingsLoadingOffline({
    bool? isDarkMode,
    required bool isOfflineModeActive,
    required bool effectiveDarkMode,
  }) : super(
          isDarkMode: isDarkMode,
          isOfflineModeActive: isOfflineModeActive,
          effectiveIsDarkMode: effectiveDarkMode,
        );

  @override
  List<Object> get props => [
        isDarkMode ?? "",
        isOfflineModeActive,
      ];
}
