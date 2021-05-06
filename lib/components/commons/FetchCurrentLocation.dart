import 'dart:io';

import 'package:geolocator/geolocator.dart';

class FetchCurrentLocation {
  static Future<Map<String, dynamic>> call() async {
    Position position = await _fetchPosition();

    if (position == null) return null;

    return {'lat': position.latitude, 'lng': position.longitude};
  }

  static Future<Position> _fetchPosition() async {
    try {
      LocationPermission status = await Geolocator.checkPermission();

      if ([LocationPermission.always, LocationPermission.whileInUse]
          .contains(status)) {
        return await Geolocator.getLastKnownPosition(
            forceAndroidLocationManager: Platform.isAndroid);
      }
    } catch (e) {}
    return null;
  }
}
