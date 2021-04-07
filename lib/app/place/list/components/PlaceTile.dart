import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/clients/CloudinaryShared.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

import '../../show/components/Index.dart' as placeShow;

class PlaceTile extends StatelessWidget {
  final Place place;

  PlaceTile({@required this.place}) : assert(place != null);

  @override
  Widget build(BuildContext context) => Column(children: [
        ScreenContainer(
            left: 15,
            right: 5,
            child: ListTile(
              leading: _avatar(),
              title: Text(place.name),
              subtitle: Text(place.fullAddress()),
              trailing: Icon(Icons.keyboard_arrow_right),
              contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
              onTap: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext xContext) {
                      return placeShow.Index(place: place);
                    });
              },
            )),
        ScreenContainer(left: 15, right: 0, child: Divider())
      ]);

  Widget _avatar() {
    if (place.coverImagePath == null || place.coverImagePath == "") {
      return CircleAvatar(
          child: Icon(Icons.restaurant_menu, color: lightGrey),
          backgroundColor: darkGreyFive);
    }

    return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
            height: 40.0,
            width: 40.0,
            child: CachedNetworkImage(
                imageUrl: CloudinaryShared.imageThumbAvatar(
                    publicId: place.coverImagePath),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()))));
  }
}
