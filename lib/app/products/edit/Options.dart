import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Products.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/components/commons/MainOptions.dart';
import 'package:nikolla_neo/app/products/edit/WeekDaysAvailablity.dart';
import 'package:nikolla_neo/app/products/edit/PhotoForm.dart';
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

  // _fetchImage(String publicId) async {
  //   Product image = Product(id: product.id, coverImagePath: publicId);

  //   Product _product = await Products()
  //       .save(domain: Domain.hosts, place: this.place, product: image);

  //   Place result = Place.fromMap(this.place.toMap());

  //   int _index = result.products.indexWhere((element) => element == _product);

  //   if (_index == -1) {
  //     result.products.add(_product);
  //   } else {
  //     result.products[_index] = _product;
  //   }

  //   await CommonDatabase.update<Place>(table: hostPlacesTable, data: result);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MainOptions(titleText: "Details"),
      BoxOptions(
          titleText: 'Photos',
          subTitleText: 'Add and edit photos',
          // coverImagePath: this.product.coverImagePath,
          // onTap: () {
          //   UploadPictureWidget(
          //           removeOptions: true,
          //           afterSaved: (String publicId) {
          //             _fetchImage(publicId);
          //           },
          //           context: context)
          //       .openDialog();
          // },
          onTap: () {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return PhotoForm(place: place, product: product);
                });
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
