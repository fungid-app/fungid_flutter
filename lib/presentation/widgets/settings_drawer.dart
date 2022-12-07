import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/app_settings_bloc.dart';
import 'package:fungid_flutter/presentation/widgets/confirm_dialog.dart';

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
            const DrawerHeader(
              child: Text('Settings'),
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: state.effectiveIsDarkMode,
              onChanged: (value) {
                context.read<AppSettingsBloc>().add(
                      ToggleDarkMode(),
                    );
              },
            ),
            SwitchListTile(
              title: const Text("Enable Offline Predictions"),
              value: state.isOfflineModeActive,
              onChanged: (value) {
                // Confirm that the user wants to switch to offline mode
                if (value) {
                  offlineModeConfirmDialog(context);
                } else {
                  context.read<AppSettingsBloc>().add(
                        ToggleOfflineMode(),
                      );
                }
              },
            ),
            state is AppSettingsLoadingOffline
                ? Text(
                    "Downloading offline model: ${state.progress}%",
                    textAlign: TextAlign.center,
                  )
                : const SizedBox.shrink(),
            state is AppSettingsErrorOffline
                ? Text(
                    "Error downloading offline predictions: ${state.message}",
                    textAlign: TextAlign.center,
                  )
                : const SizedBox.shrink(),
            state is AppSettingsLoadedOffline
                ? Text(
                    "Model Version: ${state.version}",
                    textAlign: TextAlign.center,
                  )
                : const SizedBox.shrink(),
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
