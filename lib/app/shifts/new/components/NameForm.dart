import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Shifts.dart';
import 'package:nikolla_neo/app/products/edit/Options.dart';
import 'package:nikolla_neo/app/shifts/new/components/ShiftForm.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/components/commons/DisableButton.dart';
import 'package:nikolla_neo/components/commons/SubmitButton.dart';
import 'package:nikolla_neo/components/commons/Validators.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

import 'WeekDaysAvailability.dart';

class NameForm extends StatelessWidget with ShiftForm {
  final Place place;
  final Shift shift;

  NameForm({@required this.place, @required this.shift})
      : assert(place != null && shift != null) {
    map['id'] = shift.id;
    map['name'] = shift.name;
    map['kind'] = shift.kind;
    map['week_days'] = (shift.weekDays == null ? [] : shift.weekDays);
    map['start_time'] = shift.startTime?.toString();
    map['end_time'] = shift.endTime?.toString();
  }

  @override
  checkForm() async {
    await CommonDatabase.update<Shift>(
        table: draftShiftsTable, data: Shift.fromMap(map));
  }

  bool _isPreparedToSubmit(Shift shift) {
    if (Validators.validateText('Name', shift.name,
            required: true, minText: 5, maxText: 30) !=
        null) return false;

    if (shift.weekDays.length == 0) return false;
    return _timeRangeValid(shift);
  }

  bool _timeRangeValid(Shift shift) {
    if (shift.startTime == null) return false;
    if (shift.endTime == null) return false;
    if (shift.startTime.difference(shift.endTime).inMinutes > 0) return false;

    return true;
  }

  createShift(BuildContext context, Place place, Shift shift) async {
    EasyLoading.show();

    Shift response =
        await Shifts().create(domain: Domain.hosts, place: place, shift: shift);

    Place data =
        await CommonDatabase.show<Place>(table: hostPlacesTable, data: place);

    Place placeLocal = Place.fromMap(data.toMap());

    placeLocal.shifts.add(response);

    await CommonDatabase.update<Place>(
        table: hostPlacesTable, data: placeLocal);

    await CommonDatabase.truncate<Shift>(table: draftShiftsTable);

    Navigator.pop(context);

    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: ValueListenableBuilder(
          valueListenable: Hive.box<Shift>(draftShiftsTable).listenable(),
          builder: (context, Box<Shift> box, child) {
            if (_isPreparedToSubmit(box.values.first) == true)
              return SubmitButton(onTap: () {
                createShift(
                    context, Place.fromMap(place.toMap()), box.values.first);
              });

            return DisableButton();
          }),
      appBar: placeAppBar(title: "Name - Shift", context: context),
      body: Column(children: [
        ScreenContainer(
            child: TextFormField(
          initialValue: (this.shift.name == null ? "" : this.shift.name),
          decoration: const InputDecoration(
            hintText: 'What is the shift name',
            labelText: 'Name *',
          ),
          autovalidateMode: AutovalidateMode.always,
          onChanged: (String value) {
            map['name'] = value;
            checkForm();
          },
          validator: (String value) {
            return Validators.validateText('name', value,
                required: true, minText: 5, maxText: 30);
          },
        )),
        ScreenContainer(
            left: 0,
            right: 0,
            child: BoxOptions(
                warningText:
                    (shift.weekDays == null || shift.weekDays?.length == 0),
                titleText: 'Week days available',
                subTitleText: shift.weekDaysAvailable(context),
                onTap: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return WeekDaysAvailablity(
                          place: place,
                          shift: shift,
                          afterChange: (List selected) {
                            map['week_days'] = selected;
                            checkForm();
                          },
                        );
                      });
                })),
        ScreenContainer(
            left: 0,
            right: 0,
            child: BoxOptions(
                titleText: 'Start time',
                warningText: !_timeRangeValid(shift),
                subTitleText: (shift.startTime != null
                    ? _printDuration(Duration(
                        hours: shift.startTime.hour,
                        minutes: shift.startTime.minute))
                    : ""),
                showArrow: false,
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoTimerPicker(
                          mode: CupertinoTimerPickerMode.hm,
                          minuteInterval: 15,
                          initialTimerDuration: (shift.startTime == null
                              ? Duration()
                              : Duration(
                                  hours: shift.startTime.hour,
                                  minutes: shift.startTime.minute)),
                          onTimerDurationChanged: (Duration changedTimer) {
                            map['start_time'] =
                                "2000-01-01 " + _printDuration(changedTimer);
                            checkForm();
                          },
                        );
                      });
                })),
        ScreenContainer(
            left: 0,
            right: 0,
            child: BoxOptions(
                titleText: 'End time',
                warningText: !_timeRangeValid(shift),
                subTitleText: (shift.endTime != null
                    ? _printDuration(Duration(
                        hours: shift.endTime.hour,
                        minutes: shift.endTime.minute))
                    : ""),
                showArrow: false,
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoTimerPicker(
                          mode: CupertinoTimerPickerMode.hm,
                          minuteInterval: 15,
                          initialTimerDuration: (map['end_time'] == null
                              ? Duration()
                              : Duration(
                                  hours: map['end_time'].hours,
                                  minutes: map['end_time'].minutes)),
                          onTimerDurationChanged: (Duration changedTimer) {
                            map['end_time'] =
                                "2000-01-01 " + _printDuration(changedTimer);
                            checkForm();
                          },
                        );
                      });
                }))
      ]));

  String _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes";
  }
}
