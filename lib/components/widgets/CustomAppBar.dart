import 'package:flutter/material.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class CustomAppBar extends StatefulWidget {
  final Function onTap;

  CustomAppBar({@required this.onTap});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Padding(
            padding: EdgeInsets.only(left: 25),
            child: InkWell(
              child: Icon(Icons.arrow_back, color: midGrey, size: 27.0),
              onTap: widget.onTap,
            )));
  }
}
