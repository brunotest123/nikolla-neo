import 'package:flutter/material.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

@Deprecated('Use HeaderInfoWithTwoLine instead of')
class HeaderInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerLeft,
      child: RichText(
          text: new TextSpan(children: [
        new TextSpan(
            text: "Enter your\n",
            style: TextStyle(
              color: darkGrey,
              fontSize: 23,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 0,
            )),
        new TextSpan(
            text: "mobile number",
            style: TextStyle(
              color: darkGrey,
              fontSize: 23,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              letterSpacing: 0,
            )),
      ])));
}
