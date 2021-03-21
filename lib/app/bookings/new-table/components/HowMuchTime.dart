import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/bookings/new-table/components/ConfirmationModal.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/models/Booking.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class HowMuchTime extends StatelessWidget {
  final Booking booking;

  HowMuchTime({this.booking}) : assert(booking != null);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ScreenContainer(
          top: 40,
          child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "How much time\n",
                    style: TextStyle(
                      fontFamily: 'SFUIText',
                      color: darkGrey,
                      fontSize: 19,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    )),
                TextSpan(
                    text: "do you want?",
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
          left: 20,
          child: Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: this.booking.place.durationTime().length,
                itemBuilder: (context, index) {
                  return _minAvailable(
                      context, this.booking.place.durationTime()[index]);
                },
              ))),
      ScreenContainer(top: 40, child: Divider())
    ]);
  }

  Widget _minAvailable(BuildContext context, int minutes) {
    Color colorInfo = darkGrey;

    Widget min = Text(minutes.toString(),
        style: TextStyle(
          color: colorInfo,
          fontSize: 50,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          letterSpacing: 0,
        ));
    Widget info = Text("Minutes",
        style: TextStyle(
          color: colorInfo,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: 0,
        ));

    return MaterialButton(
        onPressed: () {
          _setEndTime(context, minutes);
        },
        child: Column(
          children: [min, info],
        ));
  }

  _setEndTime(BuildContext context, int minutes) async {
    Map<String, dynamic> map = booking.toMap();
    map['end_at'] = booking.startAt.add(Duration(minutes: minutes)).toString();
    await CommonDatabase.update<Booking>(
        table: guestBookingsTable, data: Booking.fromMap(map));

    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return ConfirmationModal(booking: Booking.fromMap(map));
        });
  }
}
