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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
                  leading: Icon(Icons.edit_outlined),
                  title: Text('Edit'),
                ),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.delete,
                child: ListTile(
                  leading: Icon(Icons.delete_outlined),
                  title: Text('Delete'),
                ),
              ),
            ],
          ),
        ],
        title: const Text("Your Observation"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const ConnectivityWarning(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: UiHelpers.horizontalPadding,
                    vertical: UiHelpers.itemSpacing,
                  ),
                  child: Hero(
                    tag: 'observation_image_${observation.id}',
                    child: ObservationImageCarousel(
                      images: observation.images,
                    ),
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.location_on_outlined),
                  title: Text(observation.location.placeName),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.calendar_today_outlined),
                  title: Text(observation.dayObserved()),
                ),
                if (observation.notes != null)
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.notes_outlined),
                    title: Text(observation.notes ?? ""),
                  ),
                UiHelpers.basicDivider,
              ],
            ),
          ),
          SliverFillRemaining(
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
  final colorScheme = Theme.of(context).colorScheme;
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: const Text('Delete Observation'),
        content:
            const Text('Are you sure you want to delete this observation? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.error,
            ),
            onPressed: () {
              context.read<ViewObservationBloc>().add(
                    const ViewObservationDelete(),
                  );
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}
