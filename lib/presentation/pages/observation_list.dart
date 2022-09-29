import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain/observations.dart';
import 'package:fungid_flutter/presentation/bloc/observation_list_bloc.dart';
import 'package:fungid_flutter/presentation/pages/edit_observation.dart';
import 'package:fungid_flutter/presentation/pages/view_observation.dart';
import 'package:fungid_flutter/presentation/widgets/add_image_sheet.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';

class ObservationListPage extends StatelessWidget {
  const ObservationListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ObservationListBloc(
        repository: RepositoryProvider.of<UserObservationsRepository>(context),
      )..add(const ObservationListSubscriptionRequested()),
      child: const ObservationListView(),
    );
  }
}

class ObservationListView extends StatelessWidget {
  const ObservationListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Observations'),
      ),
      floatingActionButton: createObservationAction(context, null),
      body: BlocBuilder<ObservationListBloc, ObservationListState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.observations.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _observationCard(
                          context, state.observations[index]);
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

ListTile _observationCard(BuildContext context, UserObservation observation) {
  return ListTile(
    leading: SizedBox(
      width: 60,
      child: Image.file(
        observation.images.first.getFile(),
        fit: BoxFit.cover,
        cacheWidth: 60,
      ),
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

FloatingActionButton createObservationAction(
  BuildContext context,
  UserObservation? observation,
) {
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
                  initialObservation: observation,
                ),
              )
            },
        },
      );
    },
    child: const Icon(Icons.add),
  );
}
