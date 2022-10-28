import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({
    required LatLng location,
  }) : super(LocationState(
          location: location,
        ));

  void updateLocation(LatLng location) {
    emit(LocationState(
      location: location,
    ));
  }
}
