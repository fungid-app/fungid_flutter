import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/domain.dart';
import 'package:fungid_flutter/presentation/cubit/observation_list_cubit.dart';
import 'package:fungid_flutter/presentation/pages/take_observation_image_screen.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';

class ObservationListPage extends StatelessWidget {
  const ObservationListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserObservationsRepository repository =
        RepositoryProvider.of<UserObservationsRepository>(context);

    return BlocProvider(
      create: (_) => ObservationListCubit(repository),
      child: const ObservationListView(),
    );
  }
}

class ObservationListView extends StatelessWidget {
  const ObservationListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ObservationListCubit>().fetchObservations();
    final observations = context
        .select((ObservationListCubit cubit) => cubit.state.observations);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Observations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TakeObservationImageScreen(),
                  ));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: observations.length,
              itemBuilder: (BuildContext context, int index) {
                return _observation_card(observations[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Card _observation_card(UserObservation observation) {
  return Card(
    margin: const EdgeInsets.only(bottom: 8.0),
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              observation.dateCreated.toString(),
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_task),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.cancel),
                ),
              ],
            )
          ],
        )),
  );
}
