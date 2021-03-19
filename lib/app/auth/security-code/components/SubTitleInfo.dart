import 'package:flutter/material.dart';
import 'package:nikolla_neo/models/User.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class SubTitleInfo extends StatelessWidget {
  final User user;

  SubTitleInfo({@required this.user}) : assert(user != null);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: RichText(
            text: new TextSpan(children: [
          new TextSpan(
              text: "Verification code sent to ",
              style: TextStyle(
                fontFamily: 'SFUIText',
                color: success,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              )),
          new TextSpan(
              text: user.internationalNumber,
              style: TextStyle(
                fontFamily: 'SFUIText',
                color: midGrey,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              )),
        ])));
  }
}
