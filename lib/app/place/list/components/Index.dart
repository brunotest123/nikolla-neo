import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/place/list/components/List.dart';
import 'package:nikolla_neo/app/place/list/controllers/FetchPlacesController.dart';

class Index extends StatelessWidget {
  final ValueNotifier<Widget> _screenNotification = ValueNotifier(Container());

  Index() {
    FetchPlacesController(onFailureAction: (Widget screen) {
      _screenNotification.value = screen;
    }, onSuccessAction: () {
      _screenNotification.value = List();
    }).call();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: _screenNotification,
      builder: (context, value, child) {
        return value;
      });
}
