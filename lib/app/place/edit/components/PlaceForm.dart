import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Places.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/components/commons/DisableButton.dart';
import 'package:nikolla_neo/components/commons/SubmitButton.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

abstract class PlaceForm {
  final ValueNotifier<bool> formValidNotifier = ValueNotifier(false);
  final Map<String, dynamic> map = Map<String, dynamic>();

  checkForm();

  String textValue(dynamic value) {
    if (value == null) return "";
    if (value.toString().trim().length == 0) return "";
    return value;
  }

  Widget placeAppBar(
          {@required String title, @required BuildContext context}) =>
      AppBar(
          title: Text(title, style: TextStyle(color: darkGrey)),
          leading: Padding(
              padding: EdgeInsets.only(left: 25),
              child: InkWell(
                child: Icon(Icons.close, color: midGrey, size: 27.0),
                onTap: () {
                  Navigator.pop(context);
                },
              )));

  Widget floatingActionButton(BuildContext context) => ValueListenableBuilder(
      valueListenable: formValidNotifier,
      builder: (context, value, child) {
        if (value == true)
          return SubmitButton(onTap: () {
            fetchValue(context);
          });

        return DisableButton();
      });

  fetchValue(BuildContext context) async {
    Place result =
        await Places().update(domain: Domain.hosts, place: Place.fromMap(map));

    await CommonDatabase.update<Place>(table: hostPlacesTable, data: result);

    Navigator.pop(context);
  }
}
