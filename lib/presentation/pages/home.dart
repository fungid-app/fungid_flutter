import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/observation_list_bloc.dart';
import 'package:fungid_flutter/presentation/pages/observation_list.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ObservationListBloc(
        repository: RepositoryProvider.of<UserObservationsRepository>(context),
      )..add(const ObservationListSubscriptionRequested()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            tabs: [
              Tab(text: 'Observations'),
              // Tab(text: 'Local'),
              // Tab(text: 'Species'),
            ],
          ),
        ),
        floatingActionButton: createObservationAction(context, null),
        body: TabBarView(
          children: [
            BlocProvider(
              create: (_) => ObservationListBloc(
                repository:
                    RepositoryProvider.of<UserObservationsRepository>(context),
              )..add(const ObservationListSubscriptionRequested()),
              child: const ObservationListView(),
            ),
            // const Text('Local'),
            // const Text('Species'),
          ],
        ),
      ),
    );
  }
}
