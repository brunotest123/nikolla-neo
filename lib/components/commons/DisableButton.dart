import 'package:flutter/material.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class DisableButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      width: 70,
      height: 50,
      child: Center(
          child: Text("Save",
              style: TextStyle(
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w300,
                  fontFamily: "SFUIText",
                  fontStyle: FontStyle.normal,
                  fontSize: 15.0))),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(1),
          gradient: LinearGradient(
              colors: [lighterGrey, lightGrey],
              stops: [0, 1],
              begin: Alignment(-0.71, -0.71),
              end: Alignment(0.71, 0.71))));
}
