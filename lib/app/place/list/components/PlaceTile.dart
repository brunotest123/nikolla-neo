import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/models/Place.dart';
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
              title: Text(place.name),
              subtitle: Text("address info"),
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
}
