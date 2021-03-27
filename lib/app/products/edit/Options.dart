import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/components/commons/MainOptions.dart';
import 'package:nikolla_neo/app/products/edit/WeekDaysAvailablity.dart';
import 'package:nikolla_neo/components/commons/BoxOptions.dart';
import 'package:nikolla_neo/components/widgets/UploadPictureWidget.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';

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
      BoxOptions(
          titleText: 'Avatar',
          onTap: () {
            UploadPictureWidget(
                    afterSaved: (String publicId) {}, context: context)
                .openDialog();
          }),
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
