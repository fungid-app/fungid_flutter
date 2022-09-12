import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain.dart';
import 'package:fungid_flutter/presentation/bloc/view_observation_bloc.dart';
import 'package:fungid_flutter/presentation/pages/edit_observation.dart';
import 'package:fungid_flutter/presentation/widgets/image_carousel.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewObservationPage extends StatelessWidget {
  const ViewObservationPage({Key? key}) : super(key: key);

  static Route<void> route({required String id}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => ViewObservationBloc(
          id: id,
          observationRepository: context.read<UserObservationsRepository>(),
        )..add(const ViewObservationSubscriptionRequested()),
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
              current.observation?.predictions == null,
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
            color: Colors.white,
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
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          ImageCarousel(
            images: observation.images,
          ),
          ListTile(
            title: Text(observation.location.placeName),
          ),
          ListTile(
            title: Text(observation.dateCreated.toString()),
          ),
          ..._getPredictionsWidget(context, observation),
        ],
      ),
    );
  }

  List<ListTile> _getPredictionsWidget(
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
                    const ViewObservationGetPredctions(),
                  );
            },
          );

    var predicitons = status == ViewObservationStatus.predictionsLoading
        ? [
            const ListTile(
              title: Center(child: CircularProgressIndicator()),
            )
          ]
        : _getPredictions(context, observation.predictions);

    return [
      ListTile(
          title: Text(
            "Predictions",
            style: Theme.of(context).textTheme.headline5,
          ),
          trailing: icon),
      ...predicitons,
    ];
  }

  List<ListTile> _getPredictions(
    BuildContext context,
    Predictions? predictions,
  ) {
    if (predictions == null) {
      return [
        ListTile(
          title: const Text("No predictions available"),
          subtitle: const Text("Tap to generate"),
          onTap: () => context
              .read<ViewObservationBloc>()
              .add(const ViewObservationGetPredctions()),
        ),
      ];
    }

    return predictions.predictions
        .map((pred) => ListTile(
              onTap: () => _launchUrl(pred.species),
              title: Text(pred.species),
              subtitle: Text(pred.probability.toString()),
            ))
        .toList();
  }
}

Future<void> _launchUrl(String species) async {
  species = species.replaceAll(" ", "+");
  Uri url = Uri.parse('https://www.google.com/search?q=$species&tbm=isch');
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
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
