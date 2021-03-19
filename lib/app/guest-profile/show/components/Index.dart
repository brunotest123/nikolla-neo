import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/Users.dart';
import 'package:nikolla_neo/app/guest-profile/show/components/BoxOptions.dart';
import 'package:nikolla_neo/app/guest-profile/show/components/MainOptions.dart';
import 'package:nikolla_neo/app/guest-profile/show/components/SwitchHostOption.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/models/User.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class Index extends StatelessWidget {
  final ValueNotifier<bool> arrowNotification;

  Index({@required this.arrowNotification}) : assert(arrowNotification != null);

  _fetchUser() async {
    User user = await Users().show();

    Box<User> usersBox = Hive.box<User>(usersTable);
    usersBox.putAt(0, user);
  }

  _logout() async {
    await CommonDatabase.clear();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: arrowNotification,
      builder: (context, value, child) {
        if (value == true) {
          _fetchUser();
          return Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: 20)),
              ScreenContainer(child: Divider(color: darkGrey)),
              Padding(padding: EdgeInsets.only(top: 30)),
              MainOptions(
                titleText: 'Profile',
              ),
              SwitchHostOption(),
              BoxOptions(
                titleText: "My bookings",
                onTap: () {},
              ),
              MaterialButton(
                child: Text("Logout", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  _logout();
                },
              )
            ],
          ));
        }

        return Container();
      });
}
