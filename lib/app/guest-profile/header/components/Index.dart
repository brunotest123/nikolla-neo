import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/guest-profile/shared/components/GuestAvatar.dart';
import 'package:nikolla_neo/models/GuestProfile.dart';
import 'package:nikolla_neo/styleguide/logo.dart';

// @Deprecated('change to ListTile instead Row')
class Index extends StatelessWidget {
  final bool blackVersion;
  final GuestProfile guestProfile;
  final bool arrowUp;
  final Function afterClickOnArrow;
  final Widget trailing;

  Index(
      {@required this.guestProfile,
      this.blackVersion,
      this.arrowUp,
      this.afterClickOnArrow,
      this.trailing})
      : assert(guestProfile != null);

  @override
  Widget build(BuildContext context) => Container(
      height: 60.0,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GuestAvatar(),
        Padding(padding: EdgeInsets.only(right: 15)),
        InkWell(
            onTap: () {
              afterClickOnArrow(!arrowUp);
            },
            child: RichText(
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: new TextSpan(children: [
                  new TextSpan(
                      text: "Hello,\n",
                      style: TextStyle(
                        fontFamily: 'SFUIText',
                        color: Color(0xffffffff),
                        fontSize: 19,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                      )),
                  new TextSpan(
                      text: this.guestProfile.firstName,
                      style: TextStyle(
                        fontFamily: 'SFUIText',
                        color: Color(0xffffffff),
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      )),
                ]))),
        InkWell(
            onTap: () {
              afterClickOnArrow(!arrowUp);
            },
            child: Container(
                padding: EdgeInsets.only(
                  bottom: 5.0,
                ),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Icon(
                        (arrowUp == true
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down),
                        color: Colors.white)))),
        Expanded(child: Container()),
        (trailing == null
            ? Center(
                child: Logo(
                    height: 24.0,
                    defaultAlignment: Alignment.centerRight,
                    customPadding: EdgeInsets.all(0),
                    blackVersion: false))
            : trailing)
      ]));
}
