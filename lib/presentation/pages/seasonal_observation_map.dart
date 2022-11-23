import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/presentation/bloc/observation_map_bloc.dart';
import 'package:fungid_flutter/presentation/widgets/observation_map.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';

class SeasonalObservationMapView extends StatelessWidget {
  const SeasonalObservationMapView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ObservationMapBloc(
        locationRepository: RepositoryProvider.of<LocationRepository>(context),
      )..add(ObservationMapLoadSeasonalEvent(
          day: DateTime.now().day,
          month: DateTime.now().month,
        )),
      child: const _SeasonalObservationMapView(),
    );
  }
}

class _SeasonalObservationMapView extends StatelessWidget {
  const _SeasonalObservationMapView({
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

        return Scaffold(
          appBar: AppBar(
            title: const Text('In Season Observations'),
          ),
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: content,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
