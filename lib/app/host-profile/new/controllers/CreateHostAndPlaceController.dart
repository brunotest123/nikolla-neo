import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/HostProfiles.dart';
import 'package:nikolla_neo/api/Places.dart';
import 'package:nikolla_neo/app/BaseController.dart';
import 'package:nikolla_neo/models/HostProfile.dart';
import 'package:nikolla_neo/models/Place.dart';

class CreateHostAndPlaceController extends BaseController {
  final Function onSuccessAction;
  final Function onFailureAction;

  CreateHostAndPlaceController(
      {@required this.onSuccessAction, @required this.onFailureAction})
      : assert(onSuccessAction != null && onFailureAction != null);

  @override
  call() async {
    EasyLoading.show();

    HostProfile hostProfile = await _fetchHostProfile();

    if (hostProfile == null) return;

    Place place = await _fetchPlace(hostProfile);

    if (place == null) return;

    this.onSuccessAction(hostProfile);

    EasyLoading.dismiss();
  }

  _fetchHostProfile() async {
    HostProfile hostProfile;

    try {
      Box<HostProfile> box = await Hive.openBox<HostProfile>(hostProfilesTable);

      hostProfile = await HostProfiles().create(hostProfile: box.values.first);

      await box.clear();
      await box.add(hostProfile);
    } catch (errorMessage, stacktrace) {
      newExceptionLog(errorMessage, stacktrace,
          friendlyMessage: 'Error to create host profile');

      this.onFailureAction();
    }

    return hostProfile;
  }

  _fetchPlace(HostProfile hostProfile) async {
    Place place;

    try {
      Box<Place> box = await Hive.openBox<Place>(hostPlacesTable);

      place = await Places()
          .create(domain: Domain.hosts, place: Place(name: hostProfile.name));

      await box.clear();
      await box.add(place);
    } catch (errorMessage, stacktrace) {
      newExceptionLog(errorMessage, stacktrace,
          friendlyMessage: 'Error to create a place');

      this.onFailureAction();
    }

    return place;
  }
}
