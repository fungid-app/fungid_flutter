import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/presentation/bloc/view_prediction_bloc.dart';
import 'package:fungid_flutter/presentation/pages/view_species.dart';
import 'package:fungid_flutter/presentation/widgets/species_image.dart';
import 'package:fungid_flutter/repositories/predictions_repository.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';

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

    // var icon = status == ViewPredictionStatus.predictionsLoading
    //     ? null
    //     : IconButton(
    //         icon: const Icon(Icons.refresh),
    //         onPressed: () {
    //           context.read<ViewPredictionBloc>().add(
    //                 const ViewPredictionRefreshPredctions(),
    //               );
    //         },
    //       );

    var header = ListTile(
      minLeadingWidth: 0,
      leading: const Icon(Icons.batch_prediction_sharp),
      title: Text(
        "Predictions",
        style: Theme.of(context).textTheme.headline5,
      ),
      // trailing: icon,
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

    ListTile? infoTile = getInfoTile(observation, predictions, context);

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

  ListTile? getInfoTile(UserObservation observation, Predictions? predictions,
      BuildContext context) {
    final status =
        context.select((ViewPredictionBloc bloc) => bloc.state.status);

    if (status == ViewPredictionStatus.predictionsLoading) {
      return null;
    }

    if (context.select((ViewPredictionBloc bloc) => bloc.state.isStale)) {
      return _buildWarningTile(
        "These predictions are stale.",
        "Tap to refresh",
        context,
      );
    }

    if (predictions?.predictionType == PredictionType.offline) {
      return _buildWarningTile(
        "These predictions were generated offline.",
        "Tap to generate better predictions.",
        context,
      );
    }

    if (!context.select(
        (ViewPredictionBloc bloc) => bloc.state.isCurrentModelVersion)) {
      return _buildWarningTile(
        "There is a newer model available.",
        "Tap to generate better predictions.",
        context,
      );
    }

    return null;
  }

  ListTile _buildWarningTile(
      String title, String subtitle, BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.warning),
      trailing: const Icon(Icons.refresh),
      title: Text(title),
      dense: true,
      subtitle: Text(subtitle),
      onTap: () => context
          .read<ViewPredictionBloc>()
          .add(const ViewPredictionRefreshPredctions()),
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

    final imageMap =
        context.select((ViewPredictionBloc bloc) => bloc.state.imageMap) ?? {};

    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 3,
        indent: 10,
        endIndent: 10,
        thickness: 2,
      ),
      itemCount: predictions.predictions.length,
      itemBuilder: (context, index) {
        return getPredictionTile(
          context,
          predictions.predictions[index],
          imageMap[predictions.predictions[index].species],
        );
      },
    );
  }

  ListTile getPredictionTile(
    BuildContext context,
    Prediction pred,
    SpeciesImage? image,
  ) {
    return ListTile(
      leading: image == null
          ? null
          : SpeciesImageDisplay(
              image: image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
      onTap: () => {
        Navigator.push(
          context,
          ViewSpeciesPage.route(
            species: pred.species,
            observation: null,
          ),
        )
      },
      minLeadingWidth: 0,
      title: Text('${pred.species} - ${pred.displayProbabilty()}'),
      subtitle: LinearProgressIndicator(
        value: pred.probability,
        backgroundColor: Colors.grey,
        minHeight: 8,
        valueColor: AlwaysStoppedAnimation<Color>(
          HSLColor.fromAHSL(
            1,
            _getHueFromProbability(pred.probability),
            .75,
            .5,
          ).toColor(),
        ),
      ),
    );
  }

  double _getHueFromProbability(double probability) {
    return 100 * (pow(2 * probability, 3) / pow(2, 3));
  }
}
