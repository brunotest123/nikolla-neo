import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class RequestNewCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          print('request new code');
        },
        child: Text("Request a new code",
            style: TextStyle(
              fontFamily: 'SFUIText',
              color: brightCyan,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              letterSpacing: 0,
            )),
      ));
}
