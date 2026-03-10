import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/app_settings_bloc.dart';
import 'package:fungid_flutter/presentation/widgets/confirm_dialog.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppSettingsBloc>().state;
    if (state is AppSettingsLoaded) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/app_logo.png',
                      width: 48,
                      height: 48,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'FungID',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Settings',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer
                              .withValues(alpha: 0.8),
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: UiHelpers.horizontalPadding, vertical: 4),
              child: Text(
                'Appearance',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              secondary: const Icon(Icons.dark_mode_outlined),
              value: state.effectiveIsDarkMode,
              onChanged: (value) {
                context.read<AppSettingsBloc>().add(ToggleDarkMode());
              },
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: UiHelpers.horizontalPadding, vertical: 4),
              child: Text(
                'Data',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            SwitchListTile(
              title: const Text('Enable Offline Predictions'),
              secondary: const Icon(Icons.wifi_off_outlined),
              value: state.isOfflineModeActive,
              onChanged: (value) {
                if (value) {
                  offlineModeConfirmDialog(context);
                } else {
                  context.read<AppSettingsBloc>().add(ToggleOfflineMode());
                }
              },
            ),
            if (state is AppSettingsLoadingOffline)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: UiHelpers.horizontalPadding, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Downloading offline model: ${state.progress}%',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: state.progress / 100,
                      borderRadius:
                          BorderRadius.circular(UiHelpers.cardBorderRadius),
                    ),
                  ],
                ),
              ),
            if (state is AppSettingsErrorOffline)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: UiHelpers.horizontalPadding, vertical: 8),
                child: Card(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline,
                            size: 20,
                            color:
                                Theme.of(context).colorScheme.onErrorContainer),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            state.message,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onErrorContainer,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (state is AppSettingsLoadedOffline)
              ListTile(
                leading: const Icon(Icons.model_training),
                title: const Text('Model Version'),
                subtitle: Text(state.version),
                dense: true,
              ),
          ],
        ),
      );
    } else {
      return const Drawer(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
