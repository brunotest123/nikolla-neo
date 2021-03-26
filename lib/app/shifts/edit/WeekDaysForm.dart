import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Shifts.dart';
import 'package:nikolla_neo/app/shifts/new/components/ShiftForm.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/components/commons/WeekDaysTransale.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class WeekDaysForm extends StatelessWidget with ShiftForm {
  final Place place;
  final Shift shift;

  WeekDaysForm({@required this.place, @required this.shift})
      : assert(place != null && shift != null);

  @override
  checkForm() {
    throw UnimplementedError();
  }

  _updateWeekDays(List selected) async {
    Shift shiftUpdate = await Shifts().update(
        domain: Domain.hosts,
        place: place,
        shift: Shift(weekDays: selected, id: shift.id));

    Place response = this.place;
    response.shifts.remove(shiftUpdate);
    response.shifts.add(shiftUpdate);

    await CommonDatabase.update<Place>(table: hostPlacesTable, data: response);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: placeAppBar(title: "Week days available", context: context),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Place>(hostPlacesTable).listenable(),
          builder: (context, Box<Place> box, child) {
            Shift response = box.values
                .firstWhere((element) => element == this.place)
                .shifts
                .firstWhere((element) => element == shift);

            return CheckboxGroup(
              checkColor: darkGrey,
              activeColor: lightGrey,
              labels: WeekDaysTranslate.list(),
              checked: response.weekDays,
              labelStyle: TextStyle(
                  color: darkGrey,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  fontSize: 15.0),
              onSelected: (List selected) {
                _updateWeekDays(selected);
              },
            );
          }));
}
