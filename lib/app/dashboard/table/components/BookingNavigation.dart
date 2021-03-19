import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class BookingNavigation extends StatelessWidget {
  final double _paddingButton = 20.0;

  @override
  Widget build(BuildContext context) => Column(children: [
        Padding(padding: EdgeInsets.only(top: 20)),
        Container(
          height: 90,
          child: ListView(
              scrollDirection: Axis.horizontal, children: _listButton()),
        ),
        Padding(padding: EdgeInsets.only(top: 40))
      ]);

  List<Widget> _listButton() => [
        Padding(padding: EdgeInsets.only(left: _paddingButton)),
        _button(title: 'Menu', icon: FontAwesomeIcons.bookReader),
        _button(title: 'Basket', icon: FontAwesomeIcons.shoppingBasket),
        _button(title: 'Message', icon: FontAwesomeIcons.comment),
        _button(title: 'Invite your friends', icon: FontAwesomeIcons.users),
      ];

  Widget _button({String title, IconData icon}) => Padding(
      padding: EdgeInsets.only(right: _paddingButton),
      child: Container(
          width: 80,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: LinearGradient(
              colors: [Color(0xff25272a), Color(0xff3d3f43)],
              stops: [0, 1],
              begin: Alignment(-0.96, -0.28),
              end: Alignment(0.96, 0.28),
              // angle: 106,
              // scale: undefined,
            ),
            boxShadow: [
              BoxShadow(
                  color: Color(0x2d000000),
                  offset: Offset(0, 6),
                  blurRadius: 12,
                  spreadRadius: 0)
            ],
          ),
          child: Padding(
              padding: EdgeInsets.only(top: 5, left: 5, right: 7, bottom: 5),
              child: Column(children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(icon, color: midGrey, size: 18),
                ),
                Expanded(child: Container()),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(title,
                        style: TextStyle(
                          fontFamily: 'SFUIText',
                          color: midGrey,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0,
                        )))
              ]))));
}
