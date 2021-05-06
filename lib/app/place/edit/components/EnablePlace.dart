import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Places.dart';
import 'package:nikolla_neo/app/place/edit/components/PlaceForm.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class EnablePlace extends StatelessWidget with PlaceForm {
  final Place place;

  EnablePlace({@required this.place}) : assert(place != null) {
    map['id'] = place.id;
    map['status'] = place.status;
  }

  @override
  fetchValue(BuildContext context) async {
    EasyLoading.show();
    await Places().update(domain: Domain.hosts, place: Place.fromMap(map));
    await CommonDatabase.update<Place>(table: hostPlacesTable, data: Place.fromMap(map));
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) => ScreenContainer(
      child: Row(children: <Widget>[
        Expanded(
            child: Text("Online?",
                style: TextStyle(
                  color: darkGrey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                ))),
        Switch(
            value: (place.status == PlaceStatus.online),
            onChanged: (value) {
              map['status'] = ((place.status == PlaceStatus.online)
                  ? 'maintenance'
                  : 'online');
              fetchValue(context);
            })
      ]),
      right: 15);

  @override
  checkForm() => true;
}
