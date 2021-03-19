import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'FullNameForm.dart';
import 'package:nikolla_neo/app/guest-profile/new/components/GuestInfo.dart';
import 'package:nikolla_neo/models/GuestProfile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FullName extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: Hive.box<GuestProfile>(guestProfilesTable).listenable(),
      builder: (context, Box<GuestProfile> box, child) {
        GuestProfile _initalValue =
            (box.values.length == 0 ? GuestProfile() : box.values.first);

        return GuestInfo(
          fieldName: 'Name',
          fieldValue: _initalValue.fullName(),
          iconData: Icons.person,
          onTap: () {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext xContext) {
                  return Container(
                      height: (MediaQuery.of(context).size.height - 40),
                      child: FullNameForm(
                          guestProfilesBox: box, initalValue: _initalValue));
                });
          },
        );
      });
}
