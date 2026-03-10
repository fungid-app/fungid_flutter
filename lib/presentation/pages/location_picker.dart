import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
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

class LocationPickerView extends StatefulWidget {
  const LocationPickerView({
    Key? key,
    required this.onLocationChanged,
  }) : super(key: key);

  final Function(double, double) onLocationChanged;

  @override
  State<LocationPickerView> createState() => _LocationPickerViewState();
}

class _LocationPickerViewState extends State<LocationPickerView> {
  final MapController _mapController = MapController();
  StreamSubscription? _mapEventSubscription;

  @override
  void initState() {
    super.initState();
    _mapEventSubscription =
        _mapController.mapEventStream.listen((event) {
      if (event is MapEventMove) {
        context.read<LocationCubit>().updateLocation(event.camera.center);
      }
    });
  }

  @override
  void dispose() {
    _mapEventSubscription?.cancel();
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var location =
        context.select((LocationCubit cubit) => cubit.state.location);

    var pos = LatLng(location.latitude, location.longitude);

    var marker = Marker(
      child: const Icon(
        Icons.location_on,
        color: Colors.red,
      ),
      point: pos,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onLocationChanged(location.latitude, location.longitude);
          Navigator.pop(context);
        },
        child: const Icon(Icons.check_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: pos,
          initialZoom: 12.0,
          keepAlive: false,
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'app.fungid.flutter',
            retinaMode: MediaQuery.of(context).devicePixelRatio > 1.0,
          ),
          MarkerLayer(
            markers: [marker],
          ),
          const SimpleAttributionWidget(
            source: Text('© OpenStreetMap contributors'),
          ),
        ],
      ),
    );
  }
}
