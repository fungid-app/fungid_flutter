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

class ObservationListView extends StatelessWidget {
  const ObservationListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Directory imageStorageDirectory = context
        .select((ObservationImageCubit bloc) => bloc.state.storageDirectory);

    return BlocBuilder<ObservationListBloc, ObservationListState>(
      builder: (context, state) {
        return Scaffold(
          body: _buildBody(context, state, imageStorageDirectory),
          floatingActionButton: _createObservationAction(context),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    ObservationListState state,
    Directory imageStorageDirectory,
  ) {
    if (state.status == ObservationListStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == ObservationListStatus.failure) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline,
                size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text('Failed to load observations',
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      );
    }

    if (state.observations.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: state.observations.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildOfflineBanner(context);
        }
        return _ObservationCard(
          observation: state.observations[index - 1],
          imageStorageDirectory: imageStorageDirectory,
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 72,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'No observations yet',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the + button to photograph a mushroom and get an ID',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfflineBanner(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, internetState) {
        return BlocBuilder<AppSettingsBloc, AppSettingsState>(
          builder: (context, appSettingsState) {
            if (appSettingsState is AppSettingsLoaded &&
                !appSettingsState.isOfflineModeActive) {
              final isOnline = internetState is InternetConnected;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Card(
                  elevation: 0,
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withValues(alpha: 0.5),
                  child: ListTile(
                    leading: Icon(
                      Icons.wifi_off_rounded,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    title: const Text('Enable offline predictions'),
                    subtitle: Text(
                      isOnline
                          ? 'Get IDs without an internet connection'
                          : 'Connect to the internet to enable',
                    ),
                    trailing: isOnline
                        ? const Icon(Icons.chevron_right)
                        : null,
                    onTap: isOnline
                        ? () => offlineModeConfirmDialog(context)
                        : null,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  FloatingActionButton _createObservationAction(BuildContext context) {
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
      child: const Icon(Icons.add_a_photo_outlined),
    );
  }
}

class _ObservationCard extends StatelessWidget {
  const _ObservationCard({
    required this.observation,
    required this.imageStorageDirectory,
  });

  final UserObservation observation;
  final Directory imageStorageDirectory;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          ViewObservationPage.route(id: observation.id),
        ),
        child: Semantics(
          label:
              'Observation from ${observation.dayObserved()} at ${observation.location.placeName}',
          button: true,
          child: Row(
          children: [
            // Thumbnail
            Hero(
              tag: 'observation_image_${observation.id}',
              child: SizedBox(
                width: 100,
                height: 100,
                child: observation.images.isNotEmpty
                    ? Image.file(
                        observation.images.first
                            .getFile(imageStorageDirectory),
                        fit: BoxFit.cover,
                        cacheWidth: 200,
                      )
                    : Container(
                        color: colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.image_outlined,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
              ),
            ),
            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      observation.dayObserved(),
                      style: textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      observation.location.placeName,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (observation.images.length > 1) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${observation.images.length} photos',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.chevron_right,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
