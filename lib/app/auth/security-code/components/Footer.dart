import 'package:flutter/material.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text("By inserting the code, you agree with Nikolla’s",
                  style: TextStyle(
                    fontFamily: 'SFUIText',
                    color: lightGrey,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                  ))),
          Container(height: 5),
          Row(children: [
            _terms(),
            Text(" and ",
                style: TextStyle(
                  fontFamily: 'SFUIText',
                  color: lightGrey,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                )),
            _privacy()
          ])
        ],
      ));

  Widget _terms() => InkWell(
      onTap: () {},
      child: Text("Terms of use",
          style: TextStyle(
            fontFamily: 'SFUIText',
            color: brightCyan,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            letterSpacing: 0,
          )));

  Widget _privacy() => InkWell(
      onTap: () {},
      child: Text("Privacy Policy",
          style: TextStyle(
            fontFamily: 'SFUIText',
            color: brightCyan,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            letterSpacing: 0,
          )));
}
