import 'package:flutter/material.dart';
import 'package:nikolla_neo/models/Booking.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class BookingCountDown extends StatelessWidget {
  final Booking booking;

  BookingCountDown({@required this.booking}) : assert(booking != null);

  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerLeft,
      child: RichText(
          text: new TextSpan(children: [
        new TextSpan(
            text: "Your next booking starts in ",
            style: TextStyle(
              fontFamily: 'SFUIText',
              color: lightGrey,
              fontSize: 11,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 0,
            )),
        new TextSpan(
            text: "57 minutes…",
            style: TextStyle(
              fontFamily: 'SFUIText',
              color: lightGrey,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              letterSpacing: 0,
            )),
      ])));
}
