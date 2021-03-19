import 'package:flutter/cupertino.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class CountDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerLeft,
      child: Text("Valid for 59 seconds…",
          style: TextStyle(
            color: warmGrey,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            letterSpacing: 0,
          )));
}
