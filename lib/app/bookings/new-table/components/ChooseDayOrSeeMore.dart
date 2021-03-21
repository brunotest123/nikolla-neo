import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/bookings/new-table/components/ListOfFirstlyDays.dart';
import 'package:nikolla_neo/models/Booking.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class ChooseDayOrSeeMore extends StatelessWidget {
  final Booking booking;

  ChooseDayOrSeeMore({@required this.booking}) : assert(booking != null);

  @override
  Widget build(BuildContext context) => Column(children: [
        ScreenContainer(
            top: 40,
            child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "When do you\n",
                      style: TextStyle(
                        fontFamily: 'SFUIText',
                        color: darkGrey,
                        fontSize: 19,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      )),
                  TextSpan(
                      text: "want to come?",
                      style: TextStyle(
                        fontFamily: 'SFUIText',
                        color: darkGrey,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      )),
                ])))),
        ScreenContainer(
            top: 10,
            child: (this.booking.place.fetchAvailability().length > 5
                ? InkWell(
                    onTap: () {},
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('See more',
                            style: TextStyle(
                              color: brightCyan,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0,
                            ))))
                : Container())),
        ScreenContainer(
            top: (this.booking.place.fetchAvailability().length > 5 ? 15 : 0),
            child: ListOfFirstlyDays(booking: this.booking),
            right: 0),
        ScreenContainer(top: 40, child: Divider())
      ]);
}
