import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/location_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class GeolocationNotifier extends StateNotifier<Location> {
  GeolocationNotifier(Location state) : super(state);

  Future<void> updateLocation(Location location) async {
    state = location;
  }

  LatLng getLatLng() {
    return LatLng(state.latitude, state.longitude);
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (hasPermission != null) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      print(
          '${position.longitude} +  ${position.latitude} <<--- OBECNA LOKALIZACJA');
      state = Location(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    }).catchError((e) {
      print(e);
    });
  }

  Future<String?> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Location services are disabled, please enable it';
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location permission are denied';
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return 'Location permission are permanently denied, we cannot request permissions.';
    }
    return null;
  }
}

final geolocationProvider =
    StateNotifierProvider<GeolocationNotifier, Location>(
        (ref) => GeolocationNotifier(Location(latitude: 0, longitude: 0)));
