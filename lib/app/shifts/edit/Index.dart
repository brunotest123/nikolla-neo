import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Options.dart';

import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class Index extends StatelessWidget {
  final Place place;
  final Shift shift;

  Index({@required this.place, @required this.shift})
      : assert(place != null && shift != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: ValueListenableBuilder(
                valueListenable: Hive.box<Place>(hostPlacesTable).listenable(),
                builder: (context, Box<Place> box, child) {
                  Place placeData = box.values
                      .firstWhere((element) => element.id == place.id);

                  return Text(
                      placeData.shifts
                          .firstWhere((element) => element == this.shift)
                          .name,
                      style: TextStyle(color: darkGrey));
                }),
            leading: Container(
                padding: EdgeInsets.only(left: 25),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    minWidth: 40.0,
                    padding: EdgeInsets.all(0),
                    child: Icon(Icons.arrow_back_ios,
                        color: Color.fromRGBO(165, 165, 165, 1.0)),
                    onPressed: () {
                      Navigator.pop(context);
                    }))),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<Place>(hostPlacesTable).listenable(),
                  builder: (context, Box<Place> box, child) {
                    Place placeData = box.values
                        .firstWhere((element) => element.id == place.id);

                    return Options(
                        shift: placeData.shifts
                            .firstWhere((element) => element == shift),
                        place: placeData);
                  }))
        ]));
  }
}
