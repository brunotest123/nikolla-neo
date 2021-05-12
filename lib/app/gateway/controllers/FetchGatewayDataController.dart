import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/Bookings.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/GuestProfiles.dart';
import 'package:nikolla_neo/api/Places.dart';
import 'package:nikolla_neo/api/Sessions.dart';
import 'package:nikolla_neo/app/BaseController.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/components/commons/FetchCurrentLocation.dart';
import 'package:nikolla_neo/components/commons/FetchDeviceInfo.dart';
import 'package:nikolla_neo/models/Booking.dart';
import 'package:nikolla_neo/models/GuestProfile.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Session.dart';
import 'package:nikolla_neo/models/User.dart';

import '../../auth/mobile-number/components/Index.dart' as mobileNumber;
import '../../auth/security-code/components/Index.dart' as securityCode;
import '../../dashboard/guest/components/Index.dart' as guestDashboard;
import '../../guest-profile/new/components/Index.dart' as newGuestProfile;
import '../../locations/components/Index.dart' as location;

class FetchGatewayDataController extends BaseController {
  final bool refreshSession;
  final Function onSuccessAction;
  final Function onFailureAction;
  final ValueNotifier<Widget> screenNotifier;

  FetchGatewayDataController(
      {@required this.refreshSession,
      @required this.screenNotifier,
      @required this.onFailureAction,
      @required this.onSuccessAction});

  @override
  call() async {
    Box usersBox = await Hive.openBox<User>(usersTable);
    Box sessionBox = await Hive.openBox<Session>(sessionsTable);
    Box guestProfileBox = await Hive.openBox<GuestProfile>(guestProfilesTable);

    if (usersBox.values.length == 0) {
      this.screenNotifier.value = mobileNumber.Index();
      return;
    }

    if (sessionBox.values.length == 0) {
      this.screenNotifier.value = mobileNumber.Index();
      return;
    }

    Session session = sessionBox.values.first;

    if (session.salt == null) {
      User user = usersBox.values.first;

      this.screenNotifier.value = securityCode.Index(user: user);

      return;
    }

    if (await _updateSession() == false) {
      this.screenNotifier.value = mobileNumber.Index();
      return;
    }

    GuestProfile guestProfile = await _fetchGuestProfile();

    if (guestProfile == null) {
      if (guestProfileBox.values.first != null) {
        guestProfile = guestProfileBox.values.first;

        Map<String, dynamic> map = guestProfile.toMap();
        map['id'] = null;

        await guestProfileBox.putAt(0, GuestProfile.fromMap(map));
      }

      this.screenNotifier.value = newGuestProfile.Index();
      return;
    }

    Booking booking = await _fetchBooking();

    if (booking != null) {
      print('tem booking');
    }

    await Hive.openBox<Place>(guestPlacesTable);

    if (refreshSession == true) session = await _fetchLocation();

    if (session?.lat == null || session?.lng == null) {
      this.screenNotifier.value = location.Index(hiddenClose: true);
      return;
    }

    _fetchPlaces(session: session);

    this.screenNotifier.value = guestDashboard.Index();
  }

  Future<Booking> _fetchBooking() async {
    Box<Booking> guestBookingBox =
        await Hive.openBox<Booking>(guestBookingsTable);

    if (guestBookingBox.values.isEmpty) {
      List<Booking> bookings = await Bookings().list(domain: Domain.guests);
      await CommonDatabase.fetchAll<Booking>(
          table: guestBookingsTable, values: bookings);
    }

    if (guestBookingBox.values.length == 0) return null;

    try {
      Booking booking = guestBookingBox.values.first;

      if (booking?.id == null) return null;

      return booking;
    } catch (e, s) {
      return null;
    }
  }

  Future _fetchPlaces({@required Session session}) async {
    List<Place> places = await Places().list(
        domain: Domain.guests,
        params: {'lat': session.lat, 'lng': session.lng});

    CommonDatabase.fetchAll<Place>(table: guestPlacesTable, values: places);
  }

  Future<Session> _fetchLocation() async {
    try {
      Map<String, dynamic> map = await FetchCurrentLocation.call();

      if (map == null) return null;

      Session session = await Sessions().update(session: Session.fromMap(map));

      Map<String, dynamic> sessionParams = session.toMap();
      sessionParams['location'] = await session.findLocation();

      session = Session.fromMap(sessionParams);

      CommonDatabase.update<Session>(table: sessionsTable, data: session);

      return session;
    } catch (errorMessage, stacktrace) {
      newExceptionLog(errorMessage, stacktrace);
    }

    return null;
  }

  Future<bool> _updateSession() async {
    if (this.refreshSession == false) return true;

    try {
      Map<String, dynamic> map = await FetchDeviceInfo.call();

      Session session = await Sessions().update(session: Session.fromMap(map));

      CommonDatabase.update<Session>(table: sessionsTable, data: session);

      return true;
    } catch (errorMessage, stacktrace) {
      newExceptionLog(errorMessage, stacktrace);
    }

    return false;
  }

  Future<GuestProfile> _fetchGuestProfile() async {
    try {
      return await GuestProfiles().show();
    } catch (errorMessage, stacktrace) {
      newExceptionLog(errorMessage, stacktrace);
    }

    return null;
  }
}
