import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/observation_list_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/seasonal_species_bloc.dart';
import 'package:fungid_flutter/presentation/pages/edit_observation.dart';
import 'package:fungid_flutter/presentation/pages/observation_list.dart';
import 'package:fungid_flutter/presentation/pages/seasonal_species_list.dart';
import 'package:fungid_flutter/presentation/widgets/add_image_sheet.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';
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
          create: (_) => SeasonalSpeciesBloc(
            predictionsRepository:
                RepositoryProvider.of<PredictionsRepository>(context),
            locationRepository:
                RepositoryProvider.of<LocationRepository>(context),
          )..add(SeasonalSpeciesLoad(date: DateTime.now())),
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            tabs: [
              Tab(text: 'Observations'),
              Tab(text: 'In Season Locally'),
              // Tab(text: 'Species'),
            ],
          ),
        ),
        floatingActionButton: createObservationAction(context),
        body: const TabBarView(
          children: [
            ObservationListView(),
            SeasonalSpeciesListView(),
            // const Text('Species'),
          ],
        ),
      ),
    );
  }
}

FloatingActionButton createObservationAction(BuildContext context) {
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
                ),
              )
            },
        },
      );
    },
    child: const Icon(Icons.add),
  );
}
