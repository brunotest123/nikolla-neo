import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:nikolla_neo/models/Place.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceMap extends StatelessWidget {
  final Place place;
  final Completer<GoogleMapController> _controller = Completer();

  PlaceMap({@required this.place});

  @override
  Widget build(BuildContext context) {
    Widget googleMap = GoogleMap(
      zoomGesturesEnabled: false,
      mapToolbarEnabled: false,
      myLocationButtonEnabled: false,
      initialCameraPosition: _cameraPosition(),
      circles: {_placeRegion()},
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );

    return SizedBox(
      height: 250.0,
      child: googleMap,
    );
  }

  Circle _placeRegion() {
    return Circle(
        circleId: CircleId(place.id),
        strokeWidth: 2,
        strokeColor: Color.fromRGBO(214, 164, 75, 0.8),
        fillColor: Color.fromRGBO(214, 164, 75, 0.33),
        center: LatLng(place.lat, place.lng),
        radius: 250);
  }

  CameraPosition _cameraPosition() {
    return CameraPosition(
      target: LatLng(place.lat, place.lng),
      zoom: 14,
    );
  }
}
