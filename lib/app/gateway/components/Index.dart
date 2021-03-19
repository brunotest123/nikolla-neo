import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/app/gateway/controllers/FetchGatewayDataController.dart';
import 'package:nikolla_neo/models/Session.dart';

class Index extends StatelessWidget {
  final bool refreshSession;
  final ValueNotifier<Widget> _screenNotifier =
      ValueNotifier(Container(color: Colors.white));

  Index({this.refreshSession}) {
    _fetchUser();

    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  _fetchUser() => FetchGatewayDataController(
          refreshSession: (this.refreshSession == true ? true : false),
          screenNotifier: _screenNotifier,
          onFailureAction: () {},
          onSuccessAction: () {})
      .call();

  _subNavigation() => ValueListenableBuilder(
      valueListenable: _screenNotifier,
      builder: (context, value, child) {
        return value;
      });

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: Hive.box<Session>(sessionsTable).listenable(),
      builder: (context, Box<Session> box, child) {
        if (box.values.isEmpty) {
          _fetchUser();
        }

        return _subNavigation();
      });
}
