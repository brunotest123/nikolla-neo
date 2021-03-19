import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/GuestProfiles.dart';
import 'package:nikolla_neo/app/BaseController.dart';
import 'package:nikolla_neo/models/GuestProfile.dart';

class CreateGuestProfileController extends BaseController {
  final Function onSuccessAction;
  final Function onFailureAction;
  final Box<GuestProfile> box = Hive.box<GuestProfile>(guestProfilesTable);

  CreateGuestProfileController(
      {@required this.onSuccessAction, @required this.onFailureAction})
      : assert(onSuccessAction != null && onFailureAction != null);

  @override
  call() async {
    EasyLoading.show();

    GuestProfile guestProfile = await _saveGuestProfile();

    if (guestProfile == null) return;

    await _fetchGuestProfile(guestProfile);

    EasyLoading.dismiss();
  }

  _fetchGuestProfile(GuestProfile guestProfile) async {
    try {
      await box.putAt(0, guestProfile);

      this.onSuccessAction(guestProfile);
    } catch (errorMessage, stacktrace) {
      newExceptionLog(errorMessage, stacktrace,
          friendlyMessage: 'Failure to save info');

      this.onFailureAction();
    }
  }

  Future<GuestProfile> _saveGuestProfile() async {
    try {
      return await GuestProfiles().create(guestProfile: box.values.first);
    } catch (errorMessage, stacktrace) {
      newExceptionLog(errorMessage, stacktrace,
          friendlyMessage: 'Invalid info');

      this.onFailureAction();
    }

    return null;
  }
}
