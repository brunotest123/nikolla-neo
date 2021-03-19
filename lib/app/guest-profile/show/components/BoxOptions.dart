import 'package:flutter/material.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class BoxOptions extends StatelessWidget {
  final String titleText;
  final String subTitleText;
  final Function onTap;

  BoxOptions(
      {@required this.titleText, this.subTitleText, @required this.onTap})
      : assert(titleText != null && onTap != null);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListTile(
              subtitle: (subTitleText == null
                  ? null
                  : Text(subTitleText,
                      style: TextStyle(
                        fontFamily: 'SFUIText',
                        color: Color(0xff444444),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      ))),
              onTap: onTap,
              title: Text(titleText,
                  style: TextStyle(
                    fontFamily: 'SFUIText',
                    color: warmGrey,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  )))),
      ScreenContainer(child: Divider(color: darkGrey))
    ]);
  }
}
