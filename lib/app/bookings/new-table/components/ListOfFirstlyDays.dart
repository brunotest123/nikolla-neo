import 'package:flutter/material.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/models/Booking.dart';
import 'package:intl/intl.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class ListOfFirstlyDays extends StatelessWidget {
  final Booking booking;

  ListOfFirstlyDays({@required this.booking}) : assert(booking != null);

  @override
  Widget build(BuildContext context) {
    List<DateTime> availability = booking.place.fetchAvailability();

    return Container(
        height: 70.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: (availability.length < 5 ? availability.length : 5),
            itemBuilder: (context, index) {
              return _dateBox(context, availability[index], index);
            }));
  }

  Widget _dateBox(BuildContext context, DateTime dateTime, int index) {
    Widget subTitleView = RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: DateFormat("E, MMM dd").format(dateTime) + "\n",
          children: <TextSpan>[
            TextSpan(
                text: DateFormat("HH:mm").format(dateTime),
                style: TextStyle(fontWeight: FontWeight.w600)),
          ],
          style: TextStyle(
              fontSize: 14.0,
              color:
                  (dateTime == this.booking.startAt ? yellowNik : lightGrey))),
    );

    return InkWell(
        onTap: () {
          _setNewStartAt(dateTime);
        },
        child: Row(children: [
          Container(padding: EdgeInsets.only(right: (index == 0 ? 0 : 10))),
          Container(
              width: 90.0,
              height: 60.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [darkGreyFive, darkGreyThree], stops: [0, 1])),
              child: Center(child: subTitleView))
        ]));
  }

  _setNewStartAt(DateTime dateTime) async {
    Map<String, dynamic> map = booking.toMap();
    map['start_at'] = dateTime.toString();
    await CommonDatabase.update<Booking>(
        table: guestBookingsTable, data: Booking.fromMap(map));
  }
}
