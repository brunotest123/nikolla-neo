import 'package:flutter/material.dart';
import 'package:nikolla_neo/models/Booking.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class BookingDetails extends StatelessWidget {
  final Booking booking;

  BookingDetails({@required this.booking}) : assert(booking != null);

  @override
  Widget build(BuildContext context) => Column(children: [
        Padding(padding: EdgeInsets.only(top: 30)),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(booking.place.name,
                style: TextStyle(
                  fontFamily: 'SFUIText',
                  color: yellowNik,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                ))),
        Padding(padding: EdgeInsets.only(top: 10)),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(booking.startAt.toString(),
                style: TextStyle(
                  fontFamily: 'SFUIText',
                  color: whiteDiv,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                ))),
        Padding(padding: EdgeInsets.only(top: 5)),
        Align(
            alignment: Alignment.centerLeft,
            child: Text("6:30 PM to 8:30 PM  ",
                style: TextStyle(
                  fontFamily: 'SFUIText',
                  color: whiteDiv,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                ))),
        Padding(padding: EdgeInsets.only(top: 5)),
        Align(
            alignment: Alignment.centerLeft,
            child: Row(children: [
              Expanded(
                  child: Text(
                      "${booking.numGuest} guest${booking.numGuest > 1 ? "s" : ""}",
                      style: TextStyle(
                        fontFamily: 'SFUIText',
                        color: whiteDiv,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      ))),
              Padding(padding: EdgeInsets.only(right: 10)),
              InkWell(
                  child: Text("Booking details",
                      style: TextStyle(
                        fontFamily: 'SFUIText',
                        color: brightCyan,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      )),
                  onTap: () {})
            ]))
      ]);
}
