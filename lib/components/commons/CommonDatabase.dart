import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:nikolla_neo/models/Booking.dart';
import 'package:nikolla_neo/models/GuestProfile.dart';
import 'package:nikolla_neo/models/HostProfile.dart';
import 'package:nikolla_neo/models/Money.dart';
import 'package:nikolla_neo/models/Session.dart';
import 'package:nikolla_neo/models/User.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';
import 'package:nikolla_neo/models/Shift.dart';

class CommonDatabase {
  static Future begin() async {
    await Hive.initFlutter();
    Hive.registerAdapter(BookingAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(MoneyAdapter());
    Hive.registerAdapter(PolicyAdapter());
    Hive.registerAdapter(PlaceAdapter());
    Hive.registerAdapter(PlaceStatusAdapter());
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(ProductStatusAdapter());
    Hive.registerAdapter(SessionAdapter());
    Hive.registerAdapter(ShiftAdapter());
    Hive.registerAdapter(ShiftStatusAdapter());
    Hive.registerAdapter(GuestProfileAdapter());
    Hive.registerAdapter(HostProfileAdapter());

    await Hive.openBox<Session>(sessionsTable);
  }

  static Future insert<T>({@required String table, @required T data}) async {
    Box _box = await Hive.openBox<T>(table);
    await _box.add(data);
  }

  static Future truncate<T>({@required String table}) async {
    Box _box = await Hive.openBox<T>(table);

    await _box.clear();
  }

  static Future show<T>({@required String table, @required T data}) async {
    Box _box = await Hive.openBox<T>(table);

    T result = _box.values.firstWhere((element) => element == data);

    return result;
  }

  static Future update<T>({@required String table, @required T data}) async {
    Box _box = await Hive.openBox<T>(table);

    int _index;

    List<T> entities = _box.values.toList();

    entities.asMap().forEach((index, value) {
      if (data == value) {
        _index = 0;
        return;
      }
    });

    await _box.putAt(_index, data);
  }

  static Future fetchAll<T>(
      {@required String table, @required List<T> values}) async {
    Box _box = await Hive.openBox<T>(table);
    await _box.clear();
    await _box.addAll(values);
  }

  static Future save<T>({@required String table, @required T data}) async {}

  static Future clear() async {
    Box _bookingBox = await Hive.openBox<Booking>(guestBookingsTable);
    Box _userBox = await Hive.openBox<User>(usersTable);
    Box _sessionBox = await Hive.openBox<Session>(sessionsTable);
    Box _guestProfileBox = await Hive.openBox<GuestProfile>(guestProfilesTable);
    Box _hostProfileBox = await Hive.openBox<HostProfile>(hostProfilesTable);
    Box _hostPlacesTableBox = await Hive.openBox<Place>(hostPlacesTable);
    Box _guestPlacesTableBox = await Hive.openBox<Place>(guestPlacesTable);
    Box _draftShiftBox = await Hive.openBox<Shift>(draftShiftsTable);
    Box _guestBookingBox = await Hive.openBox<Booking>(guestBookingsTable);

    await _sessionBox.clear();

    await _bookingBox.clear();
    await _userBox.clear();
    await _guestProfileBox.clear();
    await _hostProfileBox.clear();
    await _hostPlacesTableBox.clear();
    await _guestPlacesTableBox.clear();
    await _draftShiftBox.clear();
    await _guestBookingBox.clear();
  }
}
