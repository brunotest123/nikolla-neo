import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/products/edit/WeekDaysAvailablity.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

import 'EditForm.dart';
import 'DescriptionForm.dart';
import 'EnableProduct.dart';

class Options extends StatelessWidget {
  final Place place;
  final Product product;

  Options({@required this.product, @required this.place})
      : assert(product != null && place != null);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MainOptions(titleText: "Details"),
      BoxOptions(titleText: 'Avatar', onTap: () {}),
      BoxOptions(
          titleText: 'Main info',
          subTitleText: "title, category and sale amount",
          onTap: () {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return EditForm(place: place, product: product);
                });
          }),
      BoxOptions(
          titleText: 'Description',
          onTap: () {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return DescriptionForm(place: place, product: product);
                });
          }),
      MainOptions(titleText: "Availability"),
      BoxOptions(
          titleText: 'Week days available',
          subTitleText: product.weekDaysAvailable(context),
          onTap: () {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return WeekDaysAvailablity(place: place, product: product);
                });
          }),
      (place.shifts.length == 0
          ? Container()
          : BoxOptions(
              titleText: 'Shifts available',
              subTitleText: "All shifts",
              onTap: () {})),
      EnableProduct(product: product, place: place)
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
  final bool showArrow;
  final bool warningText;

  BoxOptions(
      {@required this.titleText,
      @required this.onTap,
      this.subTitleText,
      this.showArrow,
      this.warningText})
      : assert(titleText != null && onTap != null);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListTile(
              trailing: (showArrow == false
                  ? null
                  : Icon(Icons.keyboard_arrow_right)),
              subtitle: (subTitleText == null
                  ? null
                  : Text(subTitleText,
                      style: TextStyle(
                        fontFamily: 'SFUIText',
                        color:
                            (warningText == true ? error : Color(0xff444444)),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      ))),
              onTap: onTap,
              title: Text(titleText,
                  style: TextStyle(
                    fontFamily: 'SFUIText',
                    color: (warningText == true ? error : warmGrey),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  )))),
      ScreenContainer(child: Divider())
    ]);
  }
}
