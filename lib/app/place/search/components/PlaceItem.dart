import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/place/public/components/PlaceTile.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

import '../../public/components/Index.dart' as placePublic;

class PlaceItem extends StatelessWidget {
  final Place place;
  final bool hiddenAvatar;

  PlaceItem({@required this.place, this.hiddenAvatar}) : assert(place != null);

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: () {
        showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) {
              return placePublic.Index(place: place);
            });
      },
      child: Column(children: [
        (this.hiddenAvatar != true
            ? ScreenContainer(
                child: Container(
                color: Colors.black,
                height: 200,
                width: double.infinity,
              ))
            : Container()),
        PlaceTile(place: place),
        Padding(
            padding:
                EdgeInsets.only(top: (this.hiddenAvatar != true ? 40 : 0))),
      ]));
}
