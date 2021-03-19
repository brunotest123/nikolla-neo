import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/app/guest-profile/show/components/BoxOptions.dart';
import 'package:nikolla_neo/models/User.dart';

import '../../../place/list/components/Index.dart' as placeList;

class SwitchHostOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: Hive.box<User>(usersTable).listenable(),
      builder: (context, Box<User> box, child) {
        User _initalValue = (box.values.isEmpty == true
            ? User(policies: [])
            : box.values.first);

        if (_initalValue.policies.contains(Policy.nikers)) {
          return BoxOptions(
              titleText: "Switch to host",
              onTap: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext xContext) {
                      return placeList.Index();
                    });
              });
        }

        return Container();
      });
}
