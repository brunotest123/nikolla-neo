import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Places.dart';
import 'package:nikolla_neo/app/place/edit/components/AddressForm.dart';
import 'package:nikolla_neo/app/place/edit/components/DescriptionForm.dart';
import 'package:nikolla_neo/app/place/edit/components/TitleForm.dart';
import 'package:nikolla_neo/components/commons/BoxOptions.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';
import 'package:nikolla_neo/components/widgets/UploadPictureWidget.dart';

import '../../edit/components/EnablePlace.dart';

import '../../../products/list/components/Index.dart' as productList;
import '../../../shifts/list/components/Index.dart' as shiftList;

class Options extends StatelessWidget {
  final Box<Place> box;
  final Place place;

  Options({@required this.box, @required this.place})
      : assert(box != null && place != null);

  _fetchImage(String publicId) async {
    Place result = await Places().update(
        domain: Domain.hosts,
        place: Place(id: place.id, coverImagePath: publicId));

    await CommonDatabase.update<Place>(table: hostPlacesTable, data: result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MainOptions(titleText: "About this place"),
      BoxOptions(
          titleText: 'Photos',
          coverImagePath: this.place.coverImagePath,
          onTap: () {
            UploadPictureWidget(
                    removeOptions: true,
                    afterSaved: (String publicId) {
                      _fetchImage(publicId);
                    },
                    context: context)
                .openDialog();
          }),
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
          subTitleText: place.fullAddress(),
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
      EnablePlace(place: place),
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
