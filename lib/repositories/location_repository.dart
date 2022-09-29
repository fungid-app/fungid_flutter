import 'dart:developer';

import 'package:fungid_flutter/domain/observations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepository {
  LocationRepository();

  Future<String> getLocationName(double latitude, double longitude) async {
    try {
      var data = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      var first = data.first;
      return "${first.street}, ${first.locality}, ${first.administrativeArea}, ${first.isoCountryCode}"
          .replaceAll(", ,", ",");
    } catch (e) {
      log(e.toString());
      return "Unknown";
    }
  }

  Future<void> checkPermissions() async {
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
  }

  Future<ObservationLocation> determinePosition() async {
    await checkPermissions();

    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    return ObservationLocation(
      lat: pos.latitude,
      lng: pos.longitude,
      placeName: await getLocationName(pos.latitude, pos.longitude),
    );
  }
}
