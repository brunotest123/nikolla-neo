import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/dashboard/guest/components/Header.dart';
import '../../../place/search/components/Index.dart' as searchIndex;
import '../../../place/search-bar/components/Index.dart' as searchBarIndex;
import '../../../guest-profile/show/components/Index.dart' as guestProfileShow;
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class Index extends StatelessWidget {
  final ValueNotifier<bool> _arrowNotification = ValueNotifier(false);

  @override
  Widget build(BuildContext context) => Scaffold(
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
}
