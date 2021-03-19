import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/dashboard/table/components/BookingCountDown.dart';
import 'package:nikolla_neo/app/dashboard/table/components/PlaceAddress.dart';
import 'package:nikolla_neo/app/dashboard/table/components/PlaceDetails.dart';
import 'package:nikolla_neo/models/Booking.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class BookingOverview extends StatelessWidget {
  final Booking booking;
  final ValueNotifier<bool> arrowNotification;

  BookingOverview({@required this.booking, @required this.arrowNotification})
      : assert(booking != null && arrowNotification != null);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: arrowNotification,
      builder: (context, value, child) {
        if (value == false) {
          return Column(children: [
            Padding(padding: EdgeInsets.only(top: 60)),
            ScreenContainer(child: BookingCountDown(booking: booking)),
            ScreenContainer(child: PlaceDetails(place: booking.place)),
            ScreenContainer(child: PlaceAddress(place: booking.place))
          ]);
        }

        return Container();
      });
}
