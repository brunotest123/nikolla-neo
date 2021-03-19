import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class GuestInfo extends StatelessWidget {
  final IconData iconData;
  final String fieldName;
  final String fieldValue;
  final Function onTap;

  GuestInfo(
      {@required this.iconData,
      @required this.fieldName,
      @required this.fieldValue,
      @required this.onTap})
      : assert(iconData != null &&
            fieldName != null &&
            fieldValue != null &&
            onTap != null);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 40),
      ),
      _fieldData(),
      Padding(
        padding: EdgeInsets.only(top: 14),
      ),
      Divider()
    ]);
  }

  Widget _fieldData() => InkWell(
      onTap: this.onTap,
      child: Row(children: [
        Icon(iconData, color: midGrey, size: 20),
        Padding(padding: EdgeInsets.only(right: 15)),
        Expanded(
            child: Text(
                (fieldValue.trim().length == 0 ? fieldName : fieldValue),
                style: TextStyle(
                    color:
                        (fieldValue.trim().length == 0 ? lightGrey : darkGrey),
                    fontWeight: FontWeight.w400,
                    fontFamily: "SFUIText",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0),
                textAlign: TextAlign.left))
      ]));
}
