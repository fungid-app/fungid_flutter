import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/domain/predictions.dart';
import 'package:fungid_flutter/domain/species.dart';
import 'package:fungid_flutter/presentation/bloc/view_observation_bloc.dart';
import 'package:fungid_flutter/presentation/pages/edit_observation.dart';
import 'package:fungid_flutter/presentation/pages/view_species.dart';
import 'package:fungid_flutter/presentation/widgets/observation_image_carousel.dart';
import 'package:fungid_flutter/presentation/widgets/species_image.dart';
import 'package:fungid_flutter/repositories/predictions_repository.dart';
import 'package:fungid_flutter/repositories/species_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';

class ViewObservationPage extends StatelessWidget {
  const ViewObservationPage({Key? key}) : super(key: key);

  static Route<void> route({required String id}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ViewObservationBloc(
              id: id,
              observationRepository: context.read<UserObservationsRepository>(),
              predictionsRepository: context.read<PredictionsRepository>(),
              speciesRepository: context.read<SpeciesRepository>(),
            )..add(const ViewObservationSubscriptionRequested()),
          ),
        ],
        child: const ViewObservationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ViewObservationBloc, ViewObservationState>(
          listenWhen: (previous, current) =>
              previous.status != current.status &&
              current.status == ViewObservationStatus.editing,
          listener: (context, state) => Navigator.push(
            context,
            EditObservationPage.route(initialObservation: state.observation),
          ),
        ),
        BlocListener<ViewObservationBloc, ViewObservationState>(
          listenWhen: (previous, current) =>
              previous.status != current.status &&
              current.status == ViewObservationStatus.deleted,
          listener: (context, state) => Navigator.of(context).pop(),
        ),
        BlocListener<ViewObservationBloc, ViewObservationState>(
          listenWhen: (previous, current) =>
              previous.status != current.status &&
              current.status == ViewObservationStatus.success &&
              current.observation != null &&
              current.predictions == null,
          listener: (context, state) => context.read<ViewObservationBloc>().add(
                const ViewObservationGetPredctions(),
              ),
        ),
      ],
      child: const ViewObservationView(),
    );
    // return const ViewObservationView();
  }
}

enum Menu { edit, delete }

class ViewObservationView extends StatelessWidget {
  const ViewObservationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final observation =
        context.select((ViewObservationBloc bloc) => bloc.state.observation);

    if (observation == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton<Menu>(
            onSelected: (Menu result) {
              switch (result) {
                case Menu.edit:
                  context.read<ViewObservationBloc>().add(
                        const ViewObservationEdit(),
                      );
                  break;
                case Menu.delete:
                  _delete(context);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem<Menu>(
                value: Menu.edit,
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit'),
                ),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.delete,
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                ),
              ),
            ],
          ),
        ],
        title: const Text("Your Observation"),
      ),
      body: Column(
        children: [
          ImageCarousel(
            images: observation.images,
          ),
          ListTile(
            minLeadingWidth: 0,
            leading: const Icon(Icons.location_on_outlined),
            title: Text(observation.location.placeName),
          ),
          ListTile(
            minLeadingWidth: 0,
            leading: const Icon(Icons.date_range),
            title: Text(observation.dayObserved()),
          ),
          observation.notes == null
              ? const SizedBox.shrink()
              : ListTile(
                  minLeadingWidth: 0,
                  leading: const Icon(Icons.notes),
                  title: Text(observation.notes ?? ""),
                ),
          const Divider(
            indent: 20,
            endIndent: 20,
            thickness: 2,
          ),
          Expanded(
            child: _getPredictionsWidget(context, observation),
          ),
        ],
      ),
    );
  }

  Widget _getPredictionsWidget(
    BuildContext context,
    UserObservation observation,
  ) {
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
}

double _getHueFromProbability(double probability) {
  return 100 * (math.pow(2 * probability, 3) / math.pow(2, 3));
}

void _delete(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Please Confirm'),
          content:
              const Text('Are you sure you want to delete the observation?'),
          actions: [
            TextButton(
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  context.read<ViewObservationBloc>().add(
                        const ViewObservationDelete(),
                      );
                  Navigator.of(context).pop();
                },
                child: const Text('Delete')),
          ],
        );
      });
}
