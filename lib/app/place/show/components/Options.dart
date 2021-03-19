import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/app/place/edit/components/AddressForm.dart';
import 'package:nikolla_neo/app/place/edit/components/DescriptionForm.dart';
import 'package:nikolla_neo/app/place/edit/components/TitleForm.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

import '../../../products/list/components/Index.dart' as productList;
import '../../../shifts/list/components/Index.dart' as shiftList;

class Options extends StatelessWidget {
  final Box<Place> box;
  final Place place;

  Options({@required this.box, @required this.place})
      : assert(box != null && place != null);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MainOptions(titleText: "About this place"),
      BoxOptions(titleText: 'Photos', onTap: () {}),
      BoxOptions(
          titleText: 'Title',
          subTitleText: place.name,
          onTap: () {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return TitleForm(place: place);
                });
          }),
      BoxOptions(
          titleText: 'Description',
          onTap: () {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return DescriptionForm(place: place);
                });
          }),
      BoxOptions(
          titleText: 'Location',
          onTap: () {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return AddressForm(place: place);
                });
          }),
      MainOptions(titleText: "Settings"),
      BoxOptions(
          titleText: 'Products',
          onTap: () {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return productList.Index(place: place);
                });
          }),
      BoxOptions(
          titleText: 'Shifts',
          onTap: () {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return shiftList.Index(place: place);
                });
          }),
    ]);
  }
}

class MainOptions extends StatelessWidget {
  final String titleText;

  MainOptions({@required this.titleText}) : assert(titleText != null);

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
        top: 15,
        bottom: 15,
        child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(this.titleText,
                style: TextStyle(
                  color: darkGrey,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ))));
  }
}

class BoxOptions extends StatelessWidget {
  final String titleText;
  final String subTitleText;
  final Function onTap;

  BoxOptions(
      {@required this.titleText, this.subTitleText, @required this.onTap})
      : assert(titleText != null && onTap != null);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              subtitle: (subTitleText == null
                  ? null
                  : Text(subTitleText,
                      style: TextStyle(
                        fontFamily: 'SFUIText',
                        color: Color(0xff444444),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      ))),
              onTap: onTap,
              title: Text(titleText,
                  style: TextStyle(
                    fontFamily: 'SFUIText',
                    color: warmGrey,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  )))),
      ScreenContainer(child: Divider())
    ]);
  }
}
