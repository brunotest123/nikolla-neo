import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/app/dashboard/guest/components/EditButton.dart';
import 'package:nikolla_neo/models/GuestProfile.dart';
import '../../../guest-profile/header/components/Index.dart' as guestHeader;
import '../../../guest-profile/edit/components/Index.dart' as guestProfileEdit;

class Header extends StatelessWidget {
  final ValueNotifier<bool> notification;

  Header({@required this.notification}) : assert(notification != null);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: Hive.box<GuestProfile>(guestProfilesTable).listenable(),
      builder: (context, Box<GuestProfile> box, child) {
        if (box.values.length == 0) {
          return Container();
        }

        return ValueListenableBuilder(
            valueListenable: notification,
            builder: (context, value, child) {
              return Container(
                  padding: EdgeInsets.only(top: 60),
                  child: guestHeader.Index(
                      trailing: (value == true
                          ? EditButton(
                              onClick: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (BuildContext xContext) {
                                      return guestProfileEdit.Index();
                                    });
                              },
                            )
                          : null),
                      afterClickOnArrow: (bool arrowOpen) {
                        notification.value = arrowOpen;
                      },
                      arrowUp: value,
                      guestProfile: box.values.first));
            });
      });
}
