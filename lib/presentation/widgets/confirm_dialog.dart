import 'package:flutter/material.dart';
import 'package:fungid_flutter/presentation/bloc/app_settings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showConfirmDialog(
  BuildContext context, {
  required String title,
  required String prompt,
  required Function onConfirm,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return confirmDialog(
        context,
        title: title,
        prompt: prompt,
        onConfirm: onConfirm,
      );
    },
  );
}

AlertDialog confirmDialog(
  BuildContext context, {
  required String title,
  required String prompt,
  required Function onConfirm,
}) {
  return AlertDialog(
    title: Text(title),
    content: Text(prompt),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("Cancel"),
      ),
      TextButton(
        onPressed: () {
          onConfirm();
          Navigator.of(context).pop();
        },
        child: const Text("Confirm"),
      ),
    ],
  );
}

void offlineModeConfirmDialog(BuildContext context) {
  showConfirmDialog(
    context,
    title: "Enable Offline Predictions",
    prompt:
        "You are about to enable offline predictions. This will allow you to make predictions without internet service but it will also download 60mb of data. Are you sure you want to continue?",
    onConfirm: () {
      context.read<AppSettingsBloc>().add(
            ToggleOfflineMode(),
          );
    },
  );
}
