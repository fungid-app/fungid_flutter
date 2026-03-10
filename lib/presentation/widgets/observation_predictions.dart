import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/presentation/bloc/view_prediction_bloc.dart';
import 'package:fungid_flutter/presentation/cubit/internet_cubit.dart';
import 'package:fungid_flutter/presentation/widgets/local_predictions_widget.dart';
import 'package:fungid_flutter/repositories/predictions_repository.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:fungid_flutter/utils/hue_calculation.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';

class ObservationPredictionsView extends StatelessWidget {
  final String observationID;

  const ObservationPredictionsView({
    Key? key,
    required this.observationID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewPredictionBloc(
        observationID: observationID,
        predictionsRepository: context.read<PredictionsRepository>(),
        observationRepository: context.read<UserObservationsRepository>(),
        speciesRepository: context.read<SpeciesRepository>(),
      )..add(const ViewPredictionSubscriptionRequested()),
      child: BlocListener<ViewPredictionBloc, ViewPredictionState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == ViewPredictionStatus.success &&
            current.observation != null &&
            current.predictions == null,
        listener: (context, state) => context.read<ViewPredictionBloc>().add(
              const ViewPredictionGetPredctions(),
            ),
        child: const ViewPredictionList(),
      ),
    );
  }
}

enum Menu { edit, delete }

class ViewPredictionList extends StatelessWidget {
  const ViewPredictionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((ViewPredictionBloc bloc) => bloc.state.status);
    final observation =
        context.select((ViewPredictionBloc bloc) => bloc.state.observation);

    var icon = status == ViewPredictionStatus.predictionsLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              context.read<ViewPredictionBloc>().add(
                    const ViewPredictionRefreshPredctions(),
                  );
            },
          );

    var header = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: UiHelpers.horizontalPadding,
        vertical: UiHelpers.itemSpacing,
      ),
      child: Row(
        children: [
          Icon(Icons.analytics_outlined,
              color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: UiHelpers.sectionHeader(context, "Predictions"),
          ),
          icon,
        ],
      ),
    );

    if (observation == null) {
      return Column(
        children: [
          header,
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      );
    }

    final predictions =
        context.select((ViewPredictionBloc bloc) => bloc.state.predictions);

    Widget? infoTile = getInfoTile(observation, predictions, context);

    return Column(
      children: [
        header,
        infoTile ?? const SizedBox.shrink(),
        Expanded(
          child: _getPredictionsBody(context, observation),
        ),
      ],
    );
  }

  Widget? getInfoTile(UserObservation observation, Predictions? predictions,
      BuildContext context) {
    final status =
        context.select((ViewPredictionBloc bloc) => bloc.state.status);

    if (status == ViewPredictionStatus.predictionsLoading) {
      return null;
    }

    if (context.select((ViewPredictionBloc bloc) => bloc.state.isStale)) {
      return _buildWarningTile(
        "These predictions are stale.",
        context,
      );
    }

    if (predictions?.predictionType == PredictionType.offline) {
      // return tile based on if offline or not

      return _buildWarningTile(
        "These predictions were generated offline.",
        context,
      );
    }

    if (!context.select(
        (ViewPredictionBloc bloc) => bloc.state.isCurrentModelVersion)) {
      return _buildWarningTile(
        "There is a newer model available.",
        context,
      );
    }

    return null;
  }

  Widget _buildWarningTile(String title, BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        final isOnline = state is InternetConnected;
        final colorScheme = Theme.of(context).colorScheme;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: UiHelpers.horizontalPadding,
            vertical: 4,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            color: colorScheme.tertiaryContainer,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: isOnline
                  ? () => context
                      .read<ViewPredictionBloc>()
                      .add(const ViewPredictionRefreshPredctions())
                  : null,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    Icon(Icons.info_outline,
                        size: 20, color: colorScheme.onTertiaryContainer),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onTertiaryContainer,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          Text(
                            isOnline
                                ? "Tap to get better predictions."
                                : "Connect to the internet to get better predictions.",
                            style:
                                Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: colorScheme.onTertiaryContainer
                                          .withValues(alpha: 0.8),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    if (isOnline)
                      Icon(Icons.refresh_rounded,
                          size: 20, color: colorScheme.onTertiaryContainer),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getPredictionsBody(
    BuildContext context,
    UserObservation observation,
  ) {
    final status =
        context.select((ViewPredictionBloc bloc) => bloc.state.status);

    if (status == ViewPredictionStatus.predictionsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status == ViewPredictionStatus.predictionsFailed) {
      var errorMessage = context
              .select((ViewPredictionBloc bloc) => bloc.state.errorMessage) ??
          "Error getting predictions";

      return Center(
        child: Padding(
          padding: const EdgeInsets.all(UiHelpers.horizontalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline,
                  size: 48, color: Theme.of(context).colorScheme.error),
              const SizedBox(height: 12),
              Text(errorMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 8),
              FilledButton.tonal(
                onPressed: () => context
                    .read<ViewPredictionBloc>()
                    .add(const ViewPredictionRefreshPredctions()),
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      );
    }

    final predictions =
        context.select((ViewPredictionBloc bloc) => bloc.state.predictions);

    if (predictions == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.analytics_outlined,
                size: 48,
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withValues(alpha: 0.5)),
            const SizedBox(height: 12),
            Text('No predictions available',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: () => context
                  .read<ViewPredictionBloc>()
                  .add(const ViewPredictionRefreshPredctions()),
              child: const Text('Generate predictions'),
            ),
          ],
        ),
      );
    }

    return LocalPredictionsView(
      basicPredictions: predictions.predictions,
      hueCalculation: ConservativeHueCalculation(),
      isInline: false,
    );
  }
}
