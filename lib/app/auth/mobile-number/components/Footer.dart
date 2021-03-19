import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nikolla_neo/app/auth/mobile-number/components/FooterInfo.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class Footer extends StatelessWidget {
  final ValueNotifier<bool> typingNotifier;
  final ValueNotifier<bool> _buttonNotifier = ValueNotifier<bool>(true);
  final Function onTap;

  Footer({@required this.typingNotifier, @required this.onTap})
      : assert(typingNotifier != null && onTap != null) {
    EasyLoading.addStatusCallback((status) {
      print("EasyLoading status $status");

      if (status == EasyLoadingStatus.show &&
          this.typingNotifier.value == true) {
        _buttonNotifier.value = false;
      }

      if (status == EasyLoadingStatus.dismiss &&
          this.typingNotifier.value == true) {
        _buttonNotifier.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          FooterInfo(),
          Expanded(child: Container()),
          ValueListenableBuilder(
              valueListenable: this.typingNotifier,
              builder: (context, value, child) {
                if (value == true) {
                  return _formButton;
                } else {
                  return _disableButton;
                }
              }) // button
        ],
      );

  Widget get _formButton => ValueListenableBuilder(
      valueListenable: _buttonNotifier,
      builder: (context, value, child) {
        if (value == true) return _buttonSubmit;
        return _disableButton;
      });

  Widget get _disableButton => Container(
      width: 50,
      height: 50,
      child: Icon(Icons.arrow_forward_ios, color: Colors.white),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(1),
          gradient: LinearGradient(
              colors: [lighterGrey, lightGrey],
              stops: [0, 1],
              begin: Alignment(-0.71, -0.71),
              end: Alignment(0.71, 0.71))));

  Widget get _buttonSubmit => InkWell(
      onTap: this.onTap,
      child: Container(
          width: 50,
          height: 50,
          child: Icon(Icons.arrow_forward_ios, color: Colors.white),
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              gradient: LinearGradient(
                colors: [gradientLight, gradientDark],
                stops: [0, 1],
                begin: Alignment(-0.71, -0.71),
                end: Alignment(0.71, 0.71),
                // angle: 135,
                // scale: undefined,
              ))));
}
