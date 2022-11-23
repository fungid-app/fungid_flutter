import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/observation_map_bloc.dart';
import 'package:fungid_flutter/presentation/widgets/observation_map.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';

class SpeciesObservationMapView extends StatelessWidget {
  final String species;
  const SpeciesObservationMapView({
    Key? key,
    required this.species,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ObservationMapBloc(
        locationRepository: RepositoryProvider.of<LocationRepository>(context),
      )..add(ObservationMapLoadSpeciesEvent(species: species)),
      child: const _SpeciesObservationMapView(),
    );
  }
}

class _SpeciesObservationMapView extends StatelessWidget {
  const _SpeciesObservationMapView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObservationMapBloc, ObservationMapState>(
      builder: (context, state) {
        Widget content = const Center(
          child: CircularProgressIndicator(),
        );

        if (state is ObservationMapLoaded) {
          content = Stack(
            children: [
              ObservationMapView(
                position: state.mapPosition,
                url: state.mapTileUrl,
                showMarker: state.showMarker,
              )
            ],
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            height: 300,
            child: content,
          ),
        );
      },
    );
  }
}
