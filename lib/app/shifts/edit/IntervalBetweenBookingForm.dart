import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Shifts.dart';
import 'package:nikolla_neo/app/shifts/new/components/ShiftForm.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class IntervalBetweenBookingForm extends StatelessWidget with ShiftForm {
  final Place place;
  final Shift shift;

  IntervalBetweenBookingForm({@required this.place, @required this.shift})
      : assert(place != null && shift != null);

  _updateIntervalBetweenBookings(double value) async {
    Shift shiftUpdate = await Shifts().update(
      domain: Domain.hosts,
      place: place,
      shift: Shift(intervalBetweenBooking: value.round(), id: shift.id),
    );

    Place response = this.place;
    response.shifts.remove(shiftUpdate);
    response.shifts.add(shiftUpdate);

    await CommonDatabase.update<Place>(table: hostPlacesTable, data: response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: placeAppBar(title: "Interval Between Bookings", context: context),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Place>(hostPlacesTable).listenable(),
        builder: (BuildContext context, Box<Place> box, Widget child) {
          Shift response = box.values
              .firstWhere((element) => element == this.place)
              .shifts
              .firstWhere((element) => element == shift);

          return ScreenContainer(
            child: Column(
              children: [
                Slider(
                  activeColor: darkGrey,
                  inactiveColor: lightGrey,
                  value: response.intervalBetweenBooking.toDouble(),
                  min: 0,
                  max: 60,
                  divisions: 4,
                  onChangeEnd: (double value){
                    _updateIntervalBetweenBookings(value);
                  },
                  label: response.intervalBetweenBooking.toString(),
                  onChanged: (double value) {
                  },
                ),
                Text(
                  'Interval Between Bookings: ${response.intervalBetweenBooking.toString()} min',
                  style: TextStyle(
                    fontFamily: 'SFUIText',
                    color: warmGrey,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  checkForm() {
    throw UnimplementedError();
  }
}
