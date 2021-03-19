import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/app/shifts/new/components/ShiftForm.dart';
import 'package:nikolla_neo/components/commons/WeekDaysTransale.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class WeekDaysAvailablity extends StatelessWidget with ShiftForm {
  final Place place;
  final Shift shift;
  final Function afterChange;

  WeekDaysAvailablity(
      {@required this.place, @required this.shift, @required this.afterChange})
      : assert(place != null && shift != null) {
    formValidNotifier.value = true;
    map['id'] = shift.id;
    map['name'] = shift.name;
    map['week_days'] = (shift.weekDays == null ? [] : shift.weekDays);
    map['start_time'] = shift.startTime?.toString();
    map['end_time'] = shift.endTime?.toString();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: placeAppBar(title: "Week days available", context: context),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Shift>(draftShiftsTable).listenable(),
          builder: (context, Box<Shift> box, child) {
            return CheckboxGroup(
              checkColor: darkGrey,
              activeColor: lightGrey,
              labels: WeekDaysTranslate.list(),
              checked: box.values.first.weekDays,
              labelStyle: TextStyle(
                  color: darkGrey,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  fontSize: 15.0),
              onSelected: (List selected) {
                afterChange(selected);
              },
            );
          }));

  @override
  checkForm() {
    throw UnimplementedError();
  }
}
