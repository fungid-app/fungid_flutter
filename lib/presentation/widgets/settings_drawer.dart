import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/app_settings_bloc.dart';

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
            // SwitchListTile(
            //   title: const Text("Offline Mode"),
            //   value: state.isOfflineModeActive,
            //   onChanged: (value) {
            //     context.read<AppSettingsBloc>().add(ToggleOfflineMode());
            //   },
            // ),
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
