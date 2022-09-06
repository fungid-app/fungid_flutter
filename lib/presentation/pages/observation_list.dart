import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain.dart';
import 'package:fungid_flutter/presentation/bloc/observation_list_bloc.dart';
import 'package:fungid_flutter/presentation/pages/view_observation.dart';
import 'package:fungid_flutter/presentation/widgets/create_observation_action.dart';
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
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.observations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _observationCard(context, state.observations[index]);
                  },
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
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
      width: 50,
      child: Center(
        child: Image.memory(
          observation.images.first.imageBytes,
          fit: BoxFit.cover,
        ),
      ),
    ),
    title: Text(
      observation.dateCreated.toString(),
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    onTap: () => Navigator.push(
        context, ViewObservationPage.route(observation: observation)),
  );
}
