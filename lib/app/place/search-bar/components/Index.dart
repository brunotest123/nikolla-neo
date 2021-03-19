import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/place/search/components/SearchBar.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class Index extends StatelessWidget {
  final ValueNotifier<bool> arrowNotification;

  Index({this.arrowNotification});

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      child: Column(
        children: [
          ScreenContainer(
              top: 25,
              left: 25,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: ValueListenableBuilder(
                      valueListenable: arrowNotification,
                      builder: (context, value, child) {
                        return InkWell(
                            onTap: () {
                              arrowNotification.value = !value;
                            },
                            child: Icon(
                                (value == false
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_up),
                                size: 30,
                                color: midGrey));
                      }))),
          Padding(padding: EdgeInsets.only(top: 15)),
          ScreenContainer(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Search restaurants",
                      style: TextStyle(
                        color: darkGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        letterSpacing: -0.28125,
                      )))),
          ScreenContainer(
              top: 10,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Based in your location",
                      style: TextStyle(
                        color: midGrey,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        letterSpacing: -0.20624999701976776,
                      )))),
          ScreenContainer(top: 34, child: SearchBar()),
          ScreenContainer(top: 20, left: 60, bottom: 30, child: Divider()),
        ],
      ));
}
