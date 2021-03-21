import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/models/Booking.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class ChangeNumGuest extends StatelessWidget {
  final Booking booking;

  ChangeNumGuest({@required this.booking}) : assert(booking != null);

  _setNewGuest(int guest) async {
    Map<String, dynamic> map = this.booking.toMap();
    map['num_guest'] = this.booking.numGuest + guest;

    await CommonDatabase.update<Booking>(
        table: guestBookingsTable, data: Booking.fromMap(map));
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      MaterialButton(
          onPressed: () {
            if (this.booking.numGuest < 2) return;
            _setNewGuest(-1);
          },
          child: Icon(Icons.remove_circle_outline,
              color: (this.booking.numGuest < 2 ? lightGrey : brightCyan))),
      Expanded(
          child: Column(
        children: <Widget>[
          Text(
              booking.numGuest.toString() +
                  "\n " +
                  (booking.numGuest > 1 ? "guests" : "guest"),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: darkGreyTwo,
                fontSize: 23,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              ))
        ],
      )),
      MaterialButton(
          onPressed: () {
            if (this.booking.numGuest > 9) return;
            _setNewGuest(1);
          },
          child: Icon(Icons.add_circle_outline,
              color: (this.booking.numGuest > 9 ? lightGrey : brightCyan)))
    ]);
  }
}
