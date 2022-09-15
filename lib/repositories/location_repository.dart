import 'package:fungid_flutter/domain.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepository {
  LocationRepository();

  Future<ObservationLocation> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    String place = "";
    try {
      var data = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );

      var first = data.first;
      place = "${first.street}, ${first.locality}, ${first.isoCountryCode}";
    } catch (e) {
      place = "Unknown";
    }

    return ObservationLocation(
      lat: pos.latitude,
      lng: pos.longitude,
      placeName: place,
    );
  }
}
