import 'package:flutter/material.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class PlaceDetails extends StatelessWidget {
  final Place place;

  PlaceDetails({@required this.place}) : assert(place != null);

  @override
  Widget build(BuildContext context) => Column(children: [
        Padding(padding: EdgeInsets.only(top: 30)),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(place.name,
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
            child: Text("Marc 31, 2021",
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
                  child: Text("2 guests",
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
