import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/guest-profile/shared/components/FullName.dart';
import 'package:nikolla_neo/app/guest-profile/shared/components/GuestAvatar.dart';
import 'package:nikolla_neo/app/guest-profile/shared/components/GuestEmail.dart';
import 'package:nikolla_neo/app/guest-profile/shared/components/GuestMobile.dart';
import 'package:nikolla_neo/components/widgets/HeaderInfoWithTwoLines.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          leading: Padding(
              padding: EdgeInsets.only(left: 25),
              child: InkWell(
                child: Icon(Icons.close, color: midGrey, size: 27.0),
                onTap: () {
                  Navigator.pop(context);
                },
              ))),
      body: Column(children: [
        ScreenContainer(
            child: HeaderInfoWithTwoLines(
                firstLine: 'Personal', lastLine: 'information', fontSize: 19)),
        Row(children: [
          ScreenContainer(child: GuestAvatar(), top: 40),
          Expanded(child: Container())
        ]),
        ScreenContainer(child: FullName()),
        ScreenContainer(child: GuestEmail()),
        ScreenContainer(
            top: 40,
            child: HeaderInfoWithTwoLines(
                firstLine: 'Mobile', lastLine: 'number', fontSize: 19)),
        ScreenContainer(child: GuestMobile())
      ]));
}
