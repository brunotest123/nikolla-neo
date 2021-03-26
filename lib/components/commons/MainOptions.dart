import 'package:flutter/material.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class MainOptions extends StatelessWidget {
  final String titleText;

  MainOptions({@required this.titleText}) : assert(titleText != null);

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
        top: 15,
        bottom: 15,
        child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(this.titleText,
                style: TextStyle(
                  color: darkGrey,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ))));
  }
}
