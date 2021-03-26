import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Shifts.dart';
import 'package:nikolla_neo/app/shifts/new/components/ShiftForm.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/components/commons/Validators.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class NameForm extends StatelessWidget with ShiftForm {
  final Place place;
  final Shift shift;

  NameForm({@required this.place, @required this.shift})
      : assert(place != null && shift != null);

  @override
  checkForm() {
    throw UnimplementedError();
  }

  _updateWeekDays(String name) async {
    if (Validators.validateText('name', name,
            required: true, minText: 5, maxText: 30) !=
        null) return;

    Shift shiftUpdate = await Shifts().update(
        domain: Domain.hosts,
        place: place,
        shift: Shift(name: name, id: shift.id));

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

            return ScreenContainer(
                child: TextFormField(
              initialValue: (response.name == null ? "" : response.name),
              decoration: const InputDecoration(
                hintText: 'What is the shift name',
                labelText: 'Name *',
              ),
              autovalidateMode: AutovalidateMode.always,
              onChanged: (String value) {
                _updateWeekDays(value);
              },
              validator: (String value) {
                return Validators.validateText('name', value,
                    required: true, minText: 5, maxText: 30);
              },
            ));
          }));
}
