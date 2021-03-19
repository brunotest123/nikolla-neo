import 'package:flutter/cupertino.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class FooterInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerLeft,
      child: Text("You’ll receive an SMS with the\nverification code",
          style: TextStyle(
            fontFamily: 'SFUIText',
            color: midGrey,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            letterSpacing: 0,
          )));
}
