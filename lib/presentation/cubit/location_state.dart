part of 'location_cubit.dart';

class LocationState extends Equatable {
  const LocationState({
    required this.location,
  });

  final LatLng location;

  @override
  List<Object> get props => [
        location,
      ];
}
