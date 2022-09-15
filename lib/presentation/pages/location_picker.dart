import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungid_flutter/presentation/cubit/location_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  const LocationPickerView({
    Key? key,
    required this.onLocationChanged,
  }) : super(key: key);

  final Function(double, double) onLocationChanged;

  @override
  Widget build(BuildContext context) {
    var location =
        context.select((LocationCubit cubit) => cubit.state.location);

    var pos = LatLng(location.latitude, location.longitude);

    var marker = Marker(
      markerId: const MarkerId('Selected Location'),
      position: pos,
    );

    CameraPosition kCurrentLocation = CameraPosition(
      target: pos,
      zoom: 14.4746,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onLocationChanged(location.latitude, location.longitude);
          Navigator.pop(context);
        },
        child: const Icon(Icons.check_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: GoogleMap(
        initialCameraPosition: kCurrentLocation,
        markers: {
          marker,
        },
        mapType: MapType.normal,
        onCameraMove: (position) {
          context.read<LocationCubit>().updateLocation(position.target);
        },
      ),
    );
  }
}
