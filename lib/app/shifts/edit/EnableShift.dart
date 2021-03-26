import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Shifts.dart';
import 'package:nikolla_neo/app/place/edit/components/PlaceForm.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class EnableShift extends StatelessWidget with PlaceForm {
  final Place place;
  final Shift shift;

  EnableShift({@required this.shift, @required this.place})
      : assert(shift != null && place != null) {
    map['id'] = shift.id;
    map['week_days'] = shift.weekDays;
    map['status'] = shift.status;
  }

  @override
  fetchValue(BuildContext context) async {
    EasyLoading.show();

    Shift _shift = await Shifts()
        .save(domain: Domain.hosts, place: place, shift: Shift.fromMap(map));

    Place result = Place.fromMap(place.toMap());

    int _index = result.shifts.indexWhere((element) => element == _shift);

    if (_index == -1) {
      result.shifts.add(_shift);
    } else {
      result.shifts[_index] = _shift;
    }

    await CommonDatabase.update<Place>(table: hostPlacesTable, data: result);

    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) => ScreenContainer(
      child: Row(children: <Widget>[
        Expanded(
            child: Text("Online?",
                style: TextStyle(
                  color: darkGrey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                ))),
        Switch(
            value: (shift.status == ShiftStatus.online),
            onChanged: (value) {
              map['status'] = ((shift.status == ShiftStatus.online)
                  ? 'maintenance'
                  : 'online');
              fetchValue(context);
            })
      ]),
      right: 15);

  @override
  checkForm() => true;
}
