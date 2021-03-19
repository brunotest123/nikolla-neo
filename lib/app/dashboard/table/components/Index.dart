import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/dashboard/guest/components/Header.dart';
import 'package:nikolla_neo/app/dashboard/table/components/BookingNavigation.dart';
import 'package:nikolla_neo/app/dashboard/table/components/BookingOverview.dart';
import 'package:nikolla_neo/models/Booking.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

import '../../../guest-profile/show/components/Index.dart' as guestProfileShow;

class Index extends StatelessWidget {
  final Booking booking;

  Index({@required this.booking}) : assert(booking != null);

  final ValueNotifier<bool> _arrowNotification = ValueNotifier(false);

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Container(
          child: Column(
            children: [
              ScreenContainer(child: Header(notification: _arrowNotification)),
              guestProfileShow.Index(arrowNotification: _arrowNotification),
              BookingOverview(
                  booking: this.booking, arrowNotification: _arrowNotification),
              Padding(padding: EdgeInsets.only(top: 30)),
              Expanded(child: Container()),
              BookingNavigation()
            ],
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [darkGreyFive, darkGreyThree], stops: [0, 1]))));
}
