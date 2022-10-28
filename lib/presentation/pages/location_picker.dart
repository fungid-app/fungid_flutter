import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:fungid_flutter/presentation/cubit/location_cubit.dart';
import 'package:latlong2/latlong.dart';

class LocationPicker extends StatelessWidget {
  const LocationPicker({
    Key? key,
    required this.initialLocation,
    required this.onLocationChanged,
  }) : super(key: key);

  final LatLng initialLocation;
  final Function(double, double) onLocationChanged;
  static Route<void> route({
    required double latitude,
    required double longitude,
    required Function(double, double) onLocationChanged,
  }) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => LocationCubit(
          location: LatLng(latitude, longitude),
        ),
        child: LocationPicker(
            initialLocation: LatLng(latitude, longitude),
            onLocationChanged: onLocationChanged),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LocationPickerView(
      onLocationChanged: onLocationChanged,
    );
  }
}

class LocationPickerView extends StatelessWidget {
  LocationPickerView({
    Key? key,
    required this.onLocationChanged,
  }) : super(key: key);

  final MapController _mapController = MapController();

  final Function(double, double) onLocationChanged;

  @override
  Widget build(BuildContext context) {
    var location =
        context.select((LocationCubit cubit) => cubit.state.location);

    var pos = LatLng(location.latitude, location.longitude);

    var marker = Marker(
      builder: (context) => const Icon(
        Icons.location_on,
        color: Colors.red,
      ),
      point: pos,
    );

    _mapController.mapEventStream.listen((event) {
      if (event is MapEventMove) {
        context.read<LocationCubit>().updateLocation(event.center);
      }
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onLocationChanged(location.latitude, location.longitude);
          Navigator.pop(context);
        },
        child: const Icon(Icons.check_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: pos,
          zoom: 12.0,
          keepAlive: false,
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        ),
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: '© OpenStreetMap contributors',
            onSourceTapped: () {},
          ),
        ],
        // initialCameraPosition: kCurrentLocation,
        // markers: {
        //   marker,
        // },
        // mapType: MapType.normal,
        // onCameraMove: (position) {
        //   context.read<LocationCubit>().updateLocation(position.target);
        // },
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'app.fungid.flutter',
            retinaMode: MediaQuery.of(context).devicePixelRatio > 1.0,
          ),
          MarkerLayer(
            markers: [marker],
          )
        ],
      ),
    );
  }
}
