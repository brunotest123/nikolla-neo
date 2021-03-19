import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nikolla_neo/api/Sessions.dart';
import 'package:nikolla_neo/api/Users.dart';
import 'package:nikolla_neo/app/BaseController.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/components/commons/FetchDeviceInfo.dart';
import 'package:nikolla_neo/models/Session.dart';
import 'package:nikolla_neo/models/User.dart';

class NewUserSessionController extends BaseController {
  final Map<String, dynamic> userParams;
  final Function onSuccessAction;
  final Function onFailureAction;

  NewUserSessionController(
      {@required this.userParams,
      @required this.onSuccessAction,
      @required this.onFailureAction})
      : assert(userParams != null &&
            onSuccessAction != null &&
            onFailureAction != null);

  @override
  call() async {
    await EasyLoading.show();

    await CommonDatabase.clear();

    User user = await _fetchUser();

    if (user == null) return;

    Session session = await _fetchSession(user: user);

    if (session == null) return;

    await EasyLoading.dismiss();

    this.onSuccessAction(user);
  }

  Future<Session> _fetchSession({@required User user}) async {
    Session session;

    try {
      session = await Sessions().create(
          user: user, session: Session.fromMap(await FetchDeviceInfo.call()));
      await CommonDatabase.insert<Session>(data: session, table: sessionsTable);
    } catch (errorMessage, stacktrace) {
      newExceptionLog(errorMessage, stacktrace,
          friendlyMessage: 'There is not permission to build a session');

      this.onFailureAction();
    }

    return session;
  }

  Future<User> _fetchUser() async {
    User user;

    try {
      user = await Users().update(user: User.fromMap(userParams));
      await CommonDatabase.insert<User>(data: user, table: usersTable);
    } catch (errorMessage, stacktrace) {
      newExceptionLog(errorMessage, stacktrace,
          friendlyMessage: 'Mobile number is invalid');

      this.onFailureAction();
    }

    return user;
  }
}
