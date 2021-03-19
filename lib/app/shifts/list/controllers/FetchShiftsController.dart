import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Shifts.dart';
import 'package:nikolla_neo/app/BaseController.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';

class FetchShiftsController extends BaseController {
  final Place place;

  FetchShiftsController({@required this.place});

  @override
  call() async {
    EasyLoading.show();

    _fetchShifts();

    EasyLoading.dismiss();
  }

  _fetchShifts() async {
    try {
      List<Shift> shifts =
          await Shifts().list(domain: Domain.hosts, place: place);

      Place result = Place.fromMap(place.toMap());

      result.shifts.clear();
      result.shifts.addAll(shifts);

      await CommonDatabase.update<Place>(table: hostPlacesTable, data: result);
    } catch (errorMessage, stacktrace) {
      newExceptionLog(errorMessage, stacktrace);
    }
  }
}
