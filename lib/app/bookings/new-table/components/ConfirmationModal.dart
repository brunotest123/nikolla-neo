import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/api/Bookings.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/app/bookings/new-table/components/ChangeNumGuest.dart';
import 'package:nikolla_neo/app/place/public/components/PlaceTile.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/components/widgets/HeaderInfoWithTwoLines.dart';
import 'package:nikolla_neo/models/Booking.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class ConfirmationModal extends StatelessWidget {
  final Booking booking;

  ConfirmationModal({@required this.booking}) : assert(booking != null);

  _fetchBooking(BuildContext context) async {
    await EasyLoading.show();

    await _buldBooking(context);

    await EasyLoading.dismiss();
  }

  _buldBooking(BuildContext context) async {
    try {
      Place place = this.booking.place;
      Shift shift = this.booking.place.shifts.first;

      Booking response = await Bookings().create(
          domain: Domain.guests, place: place, shift: shift, booking: booking);

      await CommonDatabase.truncate<Booking>(table: guestBookingsTable);
      await CommonDatabase.insert<Booking>(
          table: guestBookingsTable, data: response);

      Navigator.pop(context); // Close confirmation screen
      Navigator.pop(context); // Close confirmation screen
    } catch (errorMessage, stacktrace) {
      print(errorMessage);
      // newExceptionLog(errorMessage, stacktrace,
      //     friendlyMessage: 'Invalid booking');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
          onTap: () {
            _fetchBooking(context);
          },
          child: Container(
              width: 70,
              height: 50,
              child: Center(
                  child: Text("Book",
                      style: TextStyle(
                          color: lightGrey,
                          fontWeight: FontWeight.w300,
                          fontFamily: "SFUIText",
                          fontStyle: FontStyle.normal,
                          fontSize: 15.0))),
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  gradient: LinearGradient(
                    colors: [gradientLight, gradientDark],
                    stops: [0, 1],
                    begin: Alignment(-0.71, -0.71),
                    end: Alignment(0.71, 0.71),
                    // angle: 135,
                    // scale: undefined,
                  )))),
      body: ListView(children: [
        ScreenContainer(
            top: 20,
            bottom: 15,
            child: HeaderInfoWithTwoLines(
                firstLine: "Booking", lastLine: "confirmation")),
        PlaceTile(place: this.booking.place),
        ScreenContainer(
            top: 30,
            child: Text("August 19, 2018",
                style: TextStyle(
                  fontFamily: 'SFUIText',
                  color: darkGrey,
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                ))),
        ScreenContainer(
            top: 10,
            child: Text("6:30 PM to 8:30 PM",
                style: TextStyle(
                  fontFamily: 'SFUIText',
                  color: darkGrey,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                ))),
        ScreenContainer(child: Divider(), top: 15, bottom: 15),
        ScreenContainer(
            child: ValueListenableBuilder(
                valueListenable:
                    Hive.box<Booking>(guestBookingsTable).listenable(),
                builder: (context, Box<Booking> box, child) {
                  return ChangeNumGuest(booking: box.values.first);
                })),
      ]),
      appBar: AppBar(
          leading: Padding(
              padding: EdgeInsets.only(left: 25),
              child: InkWell(
                child: Icon(Icons.close, color: midGrey, size: 27.0),
                onTap: () {
                  Navigator.pop(context);
                },
              ))),
    );
  }
}
