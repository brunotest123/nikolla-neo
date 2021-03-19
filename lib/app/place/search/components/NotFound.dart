import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

import '../../../locations/components/Index.dart' as location;

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(children: [
        ScreenContainer(
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text("No restaurant found on\nthis area…",
                    style: TextStyle(
                      color: darkGrey,
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    )))),
        Padding(padding: EdgeInsets.only(top: 15)),
        ScreenContainer(
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text("Change your location and",
                    style: TextStyle(
                      color: midGrey,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    )))),
        Padding(padding: EdgeInsets.only(top: 60)),
        // add icon location.
        ScreenContainer(
            left: 20,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Image(
                  image: new AssetImage('lib/assets/imgYourLocation@3x.png'),
                  height: 40.0,
                  width: 61.0,
                ))),
        Padding(padding: EdgeInsets.only(top: 10)),
        ScreenContainer(
            child: Align(
                alignment: Alignment.bottomLeft,
                child: InkWell(
                    onTap: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) {
                            return location.Index();
                          });
                    },
                    child: Text("search again",
                        style: TextStyle(
                          color: brightCyan,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0,
                        )))))
      ]);
}
