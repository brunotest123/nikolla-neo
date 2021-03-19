import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/HostProfiles.dart';
import 'package:nikolla_neo/api/Places.dart';
import 'package:nikolla_neo/app/BaseController.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/models/HostProfile.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';

import '../../../host-profile/new/components/Index.dart' as hostProfileNew;

class FetchPlacesController extends BaseController {
  final Function onSuccessAction;
  final Function onFailureAction;

  FetchPlacesController(
      {@required this.onSuccessAction, @required this.onFailureAction});

  @override
  call() async {
    EasyLoading.show();

    Box hostProfilesBox = await Hive.openBox<HostProfile>(hostProfilesTable);

    if (hostProfilesBox.values.length == 0) {
      HostProfile hostProfile = await _fetchHostProfile();

      if (hostProfile == null) return;

      hostProfilesBox.add(hostProfile);
    } else {
      if (hostProfilesBox.values.first.id == null) {
        this.onFailureAction(hostProfileNew.Index());
        EasyLoading.dismiss();
        return;
      }
    }

    Box box = await Hive.openBox<Place>(hostPlacesTable);

    if (box.values.isEmpty == true) {
      List<Place> places = await _fetchPlaces();

      if (places.length == 0) {
        this.onFailureAction(hostProfileNew.Index());
        EasyLoading.dismiss();
        return;
      }

      await CommonDatabase.fetchAll<Place>(
          table: hostPlacesTable, values: places);
    }

    Box _box = await Hive.openBox<Shift>(draftShiftsTable);

    if (_box.values.isEmpty) {
      CommonDatabase.insert<Shift>(
          table: draftShiftsTable, data: Shift(id: 'draft', kind: 'table'));
    }

    this.onSuccessAction();

    EasyLoading.dismiss();
  }

  Future<HostProfile> _fetchHostProfile() async {
    HostProfile hostProfile;

    try {
      hostProfile = await HostProfiles().show();
    } catch (errorMessage, stacktrace) {
      newExceptionLog(errorMessage, stacktrace);

      this.onFailureAction(hostProfileNew.Index());

      EasyLoading.dismiss();
    }

    return hostProfile;
  }

  Future<List<Place>> _fetchPlaces() async {
    List<Place> places = [];

    try {
      places = await Places().list(domain: Domain.hosts);
    } catch (errorMessage, stacktrace) {
      newExceptionLog(errorMessage, stacktrace);
    }

    return places;
  }
}
