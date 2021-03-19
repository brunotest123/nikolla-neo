import 'package:flutter/material.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class EditButton extends StatelessWidget {
  final Function onClick;

  EditButton({this.onClick});

  @override
  Widget build(BuildContext context) => Center(
      child: InkWell(
          child: Text("Edit",
              style: TextStyle(
                fontFamily: 'SFUIText',
                color: brightCyan,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              )),
          onTap: onClick));
}
