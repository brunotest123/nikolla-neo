import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/dashboard/guest/components/Header.dart';
import 'package:nikolla_neo/models/Booking.dart';
import '../../../place/search/components/Index.dart' as searchIndex;
import '../../../place/search-bar/components/Index.dart' as searchBarIndex;
import '../../../guest-profile/show/components/Index.dart' as guestProfileShow;
import '../../../dashboard/table/components/Index.dart' as dashbaordTable;
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Index extends StatelessWidget {
  final ValueNotifier<bool> _arrowNotification = ValueNotifier(false);

  Widget _body(BuildContext context) => Scaffold(
      body: Container(
          child: Column(
            children: [
              ScreenContainer(child: Header(notification: _arrowNotification)),
              guestProfileShow.Index(arrowNotification: _arrowNotification),
              Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: searchBarIndex.Index(
                      arrowNotification: _arrowNotification)),
              searchIndex.Index(
                arrowNotification: _arrowNotification,
              )
            ],
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [darkGreyFive, darkGreyThree], stops: [0, 1]))));

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: Hive.box<Booking>(guestBookingsTable).listenable(),
      builder: (context, Box<Booking> box, child) {
        if (_checkBooking(box)) {
          return dashbaordTable.Index(booking: box.values.first);
        }

        return _body(context);
      });

  bool _checkBooking(Box<Booking> box) {
    if (box.values == null) return false;
    if (box.values.isEmpty) return false;

    Booking booking = box.values.first;

    return (booking.id != null);
  }
}
