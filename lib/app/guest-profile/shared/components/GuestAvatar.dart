import 'package:flutter/cupertino.dart';

class GuestAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Image(
          image: new AssetImage('lib/assets/user-profile-avatar.png'),
          height: 60.0,
        ),
      );
}
