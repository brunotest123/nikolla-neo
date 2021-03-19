import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Places.dart';
import 'package:nikolla_neo/api/Sessions.dart';
import 'package:nikolla_neo/api/clients/ServerConfig.dart';
import 'package:nikolla_neo/app/locations/components/LocationSearch.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Session.dart';
import 'package:google_maps_webservice/geocoding.dart';

import '../../gateway/components/Index.dart' as gateway;

class Index extends StatelessWidget {
  final GoogleMapsGeocoding _geocoding =
      GoogleMapsGeocoding(apiKey: ServerConfig.googleMapsApiKey);
  final ValueNotifier<Widget> _screenNotifier = ValueNotifier(Container());
  final bool hiddenClose;

  Index({this.hiddenClose}) {
    _screenNotifier.value = LocationSearch(
        hiddenClose: hiddenClose,
        geocoding: _geocoding,
        afterChooseLocation: (Location location, BuildContext context) {
          _setLocation(location, context);
        });
  }

  _setLocation(Location location, BuildContext context) async {
    Session session = await Sessions()
        .update(session: Session(lat: location.lat, lng: location.lng));

    Map<String, dynamic> sessionParams = session.toMap();
    sessionParams['location'] = await session.findLocation();

    await CommonDatabase.update<Session>(
        table: sessionsTable, data: Session.fromMap(sessionParams));

    if (hiddenClose == true) {
      _screenNotifier.value = gateway.Index();
      return;
    }

    List<Place> places = await Places().list(
        domain: Domain.guests,
        params: {'lat': location.lat, 'lng': location.lng});

    await CommonDatabase.fetchAll<Place>(
        table: guestPlacesTable, values: places);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: _screenNotifier,
      builder: (context, Widget screen, child) {
        return screen;
      });
}
