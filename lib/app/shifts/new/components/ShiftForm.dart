import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Shifts.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/components/commons/DisableButton.dart';
import 'package:nikolla_neo/components/commons/SubmitButton.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

abstract class ShiftForm {
  final ValueNotifier<bool> formValidNotifier = ValueNotifier(false);
  final Map<String, dynamic> map = Map<String, dynamic>();

  checkForm();
  Widget placeAppBar(
          {@required String title, @required BuildContext context}) =>
      AppBar(
          title: Text(title, style: TextStyle(color: darkGrey)),
          leading: Padding(
              padding: EdgeInsets.only(left: 25),
              child: InkWell(
                child: Icon(Icons.close, color: midGrey, size: 27.0),
                onTap: () {
                  Navigator.pop(context);
                },
              )));

  Widget floatingActionButton(BuildContext context, Place place) =>
      ValueListenableBuilder(
          valueListenable: formValidNotifier,
          builder: (context, value, child) {
            if (value == true)
              return SubmitButton(onTap: () {
                fetchData(context, place);
              });

            return DisableButton();
          });

  fetchData(BuildContext context, Place place) async {
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

    Navigator.pop(context);
  }

  localSaved(Place place) async {
    Shift _shift = Shift.fromMap(map);

    int _index = place.shifts.indexWhere((element) => element == _shift);

    if (_index == -1) {
      place.shifts.add(_shift);
    } else {
      place.shifts[_index] = _shift;
    }

    await CommonDatabase.update<Place>(table: hostPlacesTable, data: place);
  }
}
