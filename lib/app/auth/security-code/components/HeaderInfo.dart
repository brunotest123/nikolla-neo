import 'package:flutter/material.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

@Deprecated('Use HeaderInfoWithTwoLine instead of')
class HeaderInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerLeft,
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "Enter\n",
            style: TextStyle(
              fontFamily: 'SFUIText',
              color: darkGrey,
              fontSize: 23,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 0,
            )),
        TextSpan(
            text: "verification code",
            style: TextStyle(
              fontFamily: 'SFUIText',
              color: darkGrey,
              fontSize: 23,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              letterSpacing: 0,
            )),
      ])));
}
