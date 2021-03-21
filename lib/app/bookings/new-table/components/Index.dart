import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Shifts.dart';
import 'package:nikolla_neo/app/bookings/new-table/components/ChooseDayOrSeeMore.dart';
import 'package:nikolla_neo/app/bookings/new-table/components/HowMuchTime.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/models/Booking.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';

class Index extends StatelessWidget {
  final Place place;

  Index({this.place}) : assert(place != null) {
    _fetchPlaces();
  }

  _fetchPlaces() async {
    Place result = Place.fromMap(this.place.toMap());

    if (place.shifts.length == 0) {
      List<Shift> shifts =
          await Shifts().list(domain: Domain.guests, place: this.place);

      result.shifts.addAll(shifts);

      await CommonDatabase.update<Place>(table: guestPlacesTable, data: result);
    }

    await CommonDatabase.truncate<Booking>(table: guestBookingsTable);

    await CommonDatabase.insert<Booking>(
        table: guestBookingsTable,
        data: Booking(kind: 'table', place: result, numGuest: 2));
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: Hive.box<Place>(guestPlacesTable).listenable(),
      builder: (context, Box<Place> box, child) {
        if (box.values.isEmpty) {
          return Container();
        }

        Place placeBox =
            box.values.firstWhere((element) => element == this.place);

        if (placeBox.shifts.length == 0) {
          return Container();
        }

        return ValueListenableBuilder(
            valueListenable: Hive.box<Booking>(guestBookingsTable).listenable(),
            builder: (context, Box<Booking> box, child) {
              if (box.values.isEmpty) return Container();

              Booking booking = box.values
                  .firstWhere((element) => element.place == this.place);

              if (booking != null) {
                List<Widget> data = [ChooseDayOrSeeMore(booking: booking)];
                if (booking.startAt != null)
                  data.add(HowMuchTime(booking: booking));

                return Column(children: data);
              }

              return Container();
            });
      });
}
