import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/GuestProfiles.dart';
import 'package:nikolla_neo/api/Sessions.dart';
import 'package:nikolla_neo/app/BaseController.dart';
import 'package:nikolla_neo/models/GuestProfile.dart';
import 'package:nikolla_neo/models/Session.dart';

class SaltController extends BaseController {
  final Map<String, dynamic> sessionParams;
  final Function onSuccessAction;
  final Function onFailureAction;

  SaltController(
      {@required this.sessionParams,
      @required this.onSuccessAction,
      @required this.onFailureAction});

  @override
  call() async {
    Box sessionBox = await Hive.openBox<Session>(sessionsTable);
    Box guestProfileBox = await Hive.openBox<GuestProfile>(guestProfilesTable);

    try {
      Session session = await Sessions().buildSalt(
          session: Session(
              id: sessionBox.values.first.id,
              securityToken: sessionParams['security_token'],
              salt: 'test1123'));

      await sessionBox.clear();
      await sessionBox.add(session);

      GuestProfile guestProfile = await _fetchGuestProfile();

      await guestProfileBox.clear();
      await guestProfileBox.add(guestProfile);

      onSuccessAction();
    } catch (e, s) {
      newExceptionLog(e, s, friendlyMessage: 'Invalid token');
      onFailureAction();
    }
  }

  Future<GuestProfile> _fetchGuestProfile() async {
    try {
      return await GuestProfiles().show();
    } catch (errorMessage, stacktrace) {
      newExceptionLog(errorMessage, stacktrace);
    }

    return null;
  }
}
