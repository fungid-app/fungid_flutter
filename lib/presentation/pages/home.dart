import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/observation_list_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/species_explorer_bloc.dart';
import 'package:fungid_flutter/presentation/pages/observation_list.dart';
import 'package:fungid_flutter/presentation/pages/seasonal_species_list.dart';
import 'package:fungid_flutter/presentation/pages/species_explorer.dart';
import 'package:fungid_flutter/presentation/widgets/settings_drawer.dart';
import 'package:fungid_flutter/repositories/predictions_repository.dart';
import 'package:fungid_flutter/repositories/user_observation_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ObservationListBloc(
            repository:
                RepositoryProvider.of<UserObservationsRepository>(context),
          )..add(const ObservationListSubscriptionRequested()),
        ),
        BlocProvider(
          create: (_) => SpeciesExplorerBloc(
            predictionsRepository:
                RepositoryProvider.of<PredictionsRepository>(context),
          )..add(const SpeciesExplorerLoad()),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      // floatingActionButton: createObservationAction(context),
      child: Scaffold(
        drawer: const SettingsDrawer(),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
          title: const TabBar(
            labelPadding: EdgeInsets.zero,
            tabs: [
              Tab(text: 'Observations'),
              Tab(text: 'In Season'),
              Tab(text: 'Explorer'),
              // Tab(text: 'Species'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ObservationListView(),
            SeasonalSpeciesListView(),
            SpeciesExplorerView(),
          ],
        ),
      ),
    );
  }
}
