import 'package:flutter/material.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class SubmitButton extends StatelessWidget {
  final Function onTap;
  final String titleButton;
  final bool disabled;

  SubmitButton({@required this.onTap, this.titleButton, this.disabled})
      : assert(onTap != null);

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: () {
        if (disabled != true) this.onTap();
      },
      child: Container(
          width: 70,
          height: 50,
          child: Center(
              child: Text(
                  (this.titleButton == null ? "Save" : this.titleButton),
                  style: TextStyle(
                      color: lightGrey,
                      fontWeight: FontWeight.w300,
                      fontFamily: "SFUIText",
                      fontStyle: FontStyle.normal,
                      fontSize: 15.0))),
          decoration: (disabled == true
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  gradient: LinearGradient(
                      colors: [lighterGrey, lightGrey],
                      stops: [0, 1],
                      begin: Alignment(-0.71, -0.71),
                      end: Alignment(0.71, 0.71)))
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  gradient: LinearGradient(
                    colors: [gradientLight, gradientDark],
                    stops: [0, 1],
                    begin: Alignment(-0.71, -0.71),
                    end: Alignment(0.71, 0.71),
                    // angle: 135,
                    // scale: undefined,
                  )))));
}
