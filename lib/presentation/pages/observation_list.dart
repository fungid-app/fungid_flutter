import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/presentation/bloc/app_settings_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/observation_list_bloc.dart';
import 'package:fungid_flutter/presentation/cubit/internet_cubit.dart';
import 'package:fungid_flutter/presentation/cubit/observation_image_cubit.dart';
import 'package:fungid_flutter/presentation/pages/edit_observation.dart';
import 'package:fungid_flutter/presentation/pages/view_observation.dart';
import 'package:fungid_flutter/presentation/widgets/add_image_sheet.dart';
import 'package:fungid_flutter/presentation/widgets/confirm_dialog.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';

class ObservationListView extends StatelessWidget {
  const ObservationListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Directory imageStorageDirectory = context
        .select((ObservationImageCubit bloc) => bloc.state.storageDirectory);

    return BlocBuilder<ObservationListBloc, ObservationListState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                enableOfflinePredictionsTile(context),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.observations.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _observationCard(context,
                          state.observations[index], imageStorageDirectory);
                    },
                    separatorBuilder: (context, index) =>
                        UiHelpers.basicDivider,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: createObservationAction(context),
        );
      },
    );
  }
}

Widget enableOfflinePredictionsTile(BuildContext context) {
  return BlocBuilder<InternetCubit, InternetState>(
    builder: (context, internetState) {
      return BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, appSettingsState) {
          if (appSettingsState is AppSettingsLoaded &&
              !appSettingsState.isOfflineModeActive) {
            if (internetState is InternetConnected) {
              return Column(
                children: [
                  ListTile(
                      title: const Text('Enable offline predictions'),
                      subtitle:
                          const Text('Get IDs without an internet connection.'),
                      trailing: const Icon(
                        Icons.wifi_off,
                      ),
                      onTap: () => offlineModeConfirmDialog(context)),
                  UiHelpers.basicDivider,
                ],
              );
            } else {
              return const ListTile(
                title: Text('Enable offline predictions'),
                subtitle:
                    Text('Connect to the internet to enable offline mode.'),
                trailing: Icon(
                  Icons.wifi_off,
                ),
              );
            }
          }

          return const SizedBox.shrink();
        },
      );
    },
  );
}

ListTile _observationCard(
  BuildContext context,
  UserObservation observation,
  Directory imageStorageDirectory,
) {
  return ListTile(
    leading: SizedBox(
      width: 60,
      child: observation.images.isNotEmpty
          ? Image.file(
              observation.images.first.getFile(imageStorageDirectory),
              fit: BoxFit.cover,
              cacheWidth: 100,
            )
          : const SizedBox.shrink(),
    ),
    minLeadingWidth: 0,
    title: Text(observation.dayObserved()),
    subtitle: Text(observation.location.placeName),
    onTap: () => Navigator.push(
        context,
        ViewObservationPage.route(
          id: observation.id,
        )),
  );
}

FloatingActionButton createObservationAction(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      createAddImageSheet(
        context: context,
        onImagesSelected: (images) => {
          if (images.isNotEmpty)
            {
              Navigator.push(
                context,
                EditObservationPage.route(
                  initialImages: images,
                ),
              )
            },
        },
      );
    },
    child: const Icon(Icons.add),
  );
}
