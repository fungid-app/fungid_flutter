import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/view_observation_bloc.dart';
import 'package:fungid_flutter/presentation/pages/edit_observation.dart';
import 'package:fungid_flutter/presentation/widgets/connectivity_warning.dart';
import 'package:fungid_flutter/presentation/widgets/observation_image_carousel.dart';
import 'package:fungid_flutter/presentation/widgets/observation_predictions.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';

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
      ],
      child: const ViewObservationView(),
    );
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
          const ConnectivityWarning(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ObservationImageCarousel(
              images: observation.images,
            ),
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
          UiHelpers.basicDivider,
          Expanded(
            child: ObservationPredictionsView(
              observationID: observation.id,
            ),
          ),
        ],
      ),
    );
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
