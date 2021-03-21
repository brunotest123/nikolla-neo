import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/place/public/components/AboutUs.dart';
import 'package:nikolla_neo/app/place/search/components/PlaceItem.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class PlaceInfo extends StatelessWidget {
  final Place place;

  PlaceInfo({@required this.place}) : assert(place != null);

  @override
  Widget build(BuildContext context) => Column(children: [
        PlaceItem(place: place, hiddenAvatar: true),
        ScreenContainer(child: Divider()),
        ScreenContainer(
            right: 18,
            child: AboutUs(
              place: place,
            )),
        ScreenContainer(child: Divider()),
      ]);
}
