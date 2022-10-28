import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:fungid_flutter/presentation/bloc/species_observation_map_bloc.dart';
import 'package:fungid_flutter/repositories/location_repository.dart';
import 'package:latlong2/latlong.dart';

class SpeciesObservationMapView extends StatelessWidget {
  final String species;
  const SpeciesObservationMapView({
    Key? key,
    required this.species,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpeciesObservationMapBloc(
        species: species,
        locationRepository: RepositoryProvider.of<LocationRepository>(context),
      )..add(const SpeciesObservationMapLoadEvent()),
      child: _SpeciesObservationMapView(),
    );
  }
}

class _SpeciesObservationMapView extends StatelessWidget {
  _SpeciesObservationMapView({
    Key? key,
  }) : super(key: key);
  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeciesObservationMapBloc, SpeciesObservationMapState>(
      builder: (context, state) {
        if (state is SpeciesObservationMapLoaded) {
          return SizedBox(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      center: LatLng(state.mapPosition.latitude,
                          state.mapPosition.longitude),
                      zoom: 9.0,
                      keepAlive: true,
                      interactiveFlags:
                          InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                    ),
                    nonRotatedChildren: [
                      AttributionWidget.defaultWidget(
                        source: '© OpenStreetMap contributors',
                        onSourceTapped: () {},
                      ),
                    ],
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'app.fungid.flutter',
                        retinaMode:
                            MediaQuery.of(context).devicePixelRatio > 1.0,
                      ),
                      TileLayer(
                        urlTemplate:
                            "https://api.fungid.app/observations/heatmap/${state.species}/{z}/{x}/{y}.png",
                        userAgentPackageName: 'app.fungid.flutter',
                        retinaMode:
                            MediaQuery.of(context).devicePixelRatio > 1.0,
                        opacity: .8,
                        backgroundColor: Colors.transparent,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox(
          height: 300,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
