import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/app/guest-profile/new/components/GuestInfo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/models/User.dart';

class GuestMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: Hive.box<User>(usersTable).listenable(),
      builder: (context, Box<User> box, child) {
        User _initalValue =
            (box.values.length == 0 ? User() : box.values.first);

        return GuestInfo(
          fieldName: _initalValue.internationalNumber,
          fieldValue: '',
          iconData: Icons.mobile_friendly_outlined,
          onTap: () {},
        );
      });
}
