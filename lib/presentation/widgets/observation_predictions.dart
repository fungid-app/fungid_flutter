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
        ? null
        : IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ViewPredictionBloc>().add(
                    const ViewPredictionRefreshPredctions(),
                  );
            },
          );

    var header = ListTile(
      minLeadingWidth: 0,
      leading: const Icon(Icons.batch_prediction_sharp),
      title: Text(
        "Predictions",
        style: Theme.of(context).textTheme.headline5,
      ),
      trailing: icon,
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
        return state is InternetConnected
            ? ListTile(
                leading: const Icon(Icons.warning),
                trailing: const Icon(Icons.refresh),
                title: Text(title),
                dense: true,
                subtitle: const Text("Tap to get better predictions."),
                onTap: () => context
                    .read<ViewPredictionBloc>()
                    .add(const ViewPredictionRefreshPredctions()),
              )
            : ListTile(
                leading: const Icon(Icons.warning),
                title: Text(title),
                subtitle: const Text(
                    "Connect to the internet to get better predictions."),
                dense: true,
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

      return Text(errorMessage);
    }

    final predictions =
        context.select((ViewPredictionBloc bloc) => bloc.state.predictions);

    if (predictions == null) {
      return ListTile(
        minLeadingWidth: 0,
        title: const Text("No predictions available"),
        subtitle: const Text("Tap to generate"),
        onTap: () => context
            .read<ViewPredictionBloc>()
            .add(const ViewPredictionRefreshPredctions()),
      );
    }

    return LocalPredictionsView(
      basicPredictions: predictions.predictions,
      hueCalculation: ConservativeHueCalculation(),
      isInline: false,
    );
  }
}
