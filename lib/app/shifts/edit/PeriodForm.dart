import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Shifts.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/components/commons/SubmitButton.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class PeriodForm extends StatelessWidget {
  final ValueNotifier<bool> formValidNotifier = ValueNotifier(false);
  final Place place;
  final Shift shift;
  final String field;

  PeriodForm(
      {@required this.place, @required this.shift, @required this.field}) {
    formValidNotifier.value = _timeRangeValid(shift);
  }

  bool _timeRangeValid(Shift shift) {
    if (shift.startTime == null) return false;
    if (shift.endTime == null) return false;
    if (shift.startTime.difference(shift.endTime).inMinutes >= 0) return false;

    return true;
  }

  _updateData(Duration changedTimer) async {
    String _printDuration(Duration duration) {
      String twoDigits(int n) {
        if (n >= 10) return "$n";
        return "0$n";
      }

      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes";
    }

    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = shift.id;
    map['week_days'] = shift.weekDays;
    map[(this.field == 'start' ? "start_time" : "end_time")] =
        "2000-01-01 " + _printDuration(changedTimer);

    map[(this.field == 'start' ? "end_time" : "start_time")] =
        (this.field == 'start'
            ? shift.endTime.toString()
            : shift.startTime.toString());

    Shift params = Shift.fromMap(map);

    formValidNotifier.value = _timeRangeValid(params);

    if (_timeRangeValid(params) == false) {
      return;
    }

    Shift shiftUpdate = await Shifts()
        .update(domain: Domain.hosts, place: place, shift: params);

    Place response = this.place;
    response.shifts.remove(shiftUpdate);
    response.shifts.add(shiftUpdate);

    await CommonDatabase.update<Place>(table: hostPlacesTable, data: response);
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = this.field == 'start' ? shift.startTime : shift.endTime;

    return Container(
        height: 350,
        child: Column(children: [
          Padding(padding: EdgeInsets.only(top: 15)),
          Text(
              (this.field == 'start' ? "Start time" : "End time") +
                  " from ${this.shift.name}",
              style: TextStyle(
                fontFamily: 'SFUIText',
                color: darkGrey,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                letterSpacing: -0.28125,
              )),
          Padding(padding: EdgeInsets.only(top: 15)),
          CupertinoTimerPicker(
              onTimerDurationChanged: (Duration changedTimer) {
                _updateData(changedTimer);
              },
              initialTimerDuration:
                  Duration(hours: date.hour, minutes: date.minute),
              mode: CupertinoTimerPickerMode.hm,
              minuteInterval: 15),
          Expanded(child: Container()),
          ScreenContainer(
              bottom: 30,
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: ValueListenableBuilder(
                      valueListenable: formValidNotifier,
                      builder: (context, value, child) {
                        return SubmitButton(
                          titleButton: "Ok",
                          disabled: !value,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        );
                      })))
        ]));
  }
}
