import 'package:flutter/material.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class HeaderAppBar extends StatelessWidget {
  final Place place;
  final ScrollController controller;

  HeaderAppBar({@required this.place, @required this.controller})
      : assert(place != null && controller != null);

  @override
  Widget build(BuildContext context) => SliverAppBar(
        backgroundColor: Colors.white,
        pinned: true,
        elevation: 0,
        leading: Padding(
            padding: EdgeInsets.only(left: 17),
            child: IconButton(
              icon: Icon(Icons.close),
              color: midGrey,
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        title: Text(place.name,
            style: TextStyle(
              color: darkGrey,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              letterSpacing: 0,
            )),
      );
}
