import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/presentation/bloc/view_observation_bloc.dart';
import 'package:fungid_flutter/presentation/pages/view_species.dart';
import 'package:fungid_flutter/presentation/widgets/species_image.dart';

class ObservationPredictionsView extends StatelessWidget {
  final UserObservation observation;

  const ObservationPredictionsView({
    Key? key,
    required this.observation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((ViewObservationBloc bloc) => bloc.state.status);

    var icon = status == ViewObservationStatus.predictionsLoading
        ? null
        : IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ViewObservationBloc>().add(
                    const ViewObservationRefreshPredctions(),
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
        trailing: icon);

    final predictions =
        context.select((ViewObservationBloc bloc) => bloc.state.predictions);

    var isStale = (observation.lastUpdated ?? DateTime.now())
        .subtract(
          const Duration(seconds: 1),
        )
        .isAfter(predictions?.dateCreated ?? DateTime.now());

    return Column(
      children: [
        header,
        !isStale
            ? const SizedBox.shrink()
            : ListTile(
                leading: const Icon(Icons.warning),
                trailing: const Icon(Icons.refresh),
                title: const Text("Predictions are out of date"),
                subtitle: const Text("Tap to refresh"),
                onTap: () => context
                    .read<ViewObservationBloc>()
                    .add(const ViewObservationRefreshPredctions()),
              ),
        Expanded(
          child: _getPredictionsBody(context, observation),
        ),
      ],
    );
  }

  Widget _getPredictionsBody(
    BuildContext context,
    UserObservation observation,
  ) {
    final status =
        context.select((ViewObservationBloc bloc) => bloc.state.status);

    if (status == ViewObservationStatus.predictionsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status == ViewObservationStatus.predictionsFailed) {
      var errorMessage = context
              .select((ViewObservationBloc bloc) => bloc.state.errorMessage) ??
          "Error getting predictions";

      return Text(errorMessage);
    }

    final predictions =
        context.select((ViewObservationBloc bloc) => bloc.state.predictions);

    if (predictions == null) {
      return ListTile(
        minLeadingWidth: 0,
        title: const Text("No predictions available"),
        subtitle: const Text("Tap to generate"),
        onTap: () => context
            .read<ViewObservationBloc>()
            .add(const ViewObservationRefreshPredctions()),
      );
    }

    final imageMap =
        context.select((ViewObservationBloc bloc) => bloc.state.imageMap) ?? {};

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
