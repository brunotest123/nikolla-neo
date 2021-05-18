import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nikolla_neo/app/place/show/components/Options.dart';
import 'package:nikolla_neo/app/shifts/edit/EnableShift.dart';
import 'package:nikolla_neo/app/shifts/edit/IntervalBetweenBookingForm.dart';
import 'package:nikolla_neo/app/shifts/edit/PeriodForm.dart';
import 'NameForm.dart';
import 'package:nikolla_neo/app/shifts/edit/WeekDaysForm.dart';
import 'package:nikolla_neo/components/commons/BoxOptions.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';

class Options extends StatelessWidget {
  final Place place;
  final Shift shift;

  Options({@required this.shift, @required this.place})
      : assert(shift != null && place != null);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      BoxOptions(
          titleText: 'Name',
          subTitleText: shift.name,
          onTap: () {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return NameForm(place: place, shift: shift);
                });
          }),
      BoxOptions(
          titleText: 'Week days',
          subTitleText: shift.weekDaysAvailable(context),
          onTap: () {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return WeekDaysForm(place: place, shift: shift);
                });
          }),
      BoxOptions(
          titleText: "Start time",
          subTitleText: DateFormat("HH:mm").format(shift.startTime),
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return PeriodForm(place: place, shift: shift, field: 'start');
                });
          }),
      BoxOptions(
          titleText: "End time",
          subTitleText: DateFormat("HH:mm").format(shift.endTime),
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return PeriodForm(place: place, shift: shift, field: 'end');
                });
          }),
      MainOptions(titleText: "Settings"),
      BoxOptions(
          showArrow: false,
          titleText: "Interval between booking",
          subTitleText: shift.intervalBetweenBooking.toString() + " min",
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return IntervalBetweenBookingForm(place: place, shift: shift);
              },
            );
          }),
      BoxOptions(
          showArrow: false,
          titleText: "Rolling days booking",
          subTitleText: shift.rollingDaysBooking.toString() + " days",
          onTap: () {}),
      BoxOptions(
          showArrow: false,
          titleText: "Maximum number of guest by slot",
          subTitleText: shift.maxNumberOfGuests.toString() + " guests",
          onTap: () {}),
      MainOptions(titleText: "Availability"),
      EnableShift(shift: shift, place: place)
    ]);
  }
}
