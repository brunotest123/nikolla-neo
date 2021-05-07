import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/app/place/list/components/PlaceTile.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Listing", style: TextStyle(color: darkGrey)),
            leading: Container(
              padding: EdgeInsets.only(left: 25),
              child: MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                minWidth: 40.0,
                padding: EdgeInsets.all(0),
                child: Icon(Icons.clear,
                    color: Color.fromRGBO(165, 165, 165, 1.0)),
                onPressed: () {
                  Navigator.pop(context);
                  return;
                },
              ),
            )),
        body: ScreenContainer(
            left: 15,
            right: 0,
            child: ValueListenableBuilder(
                valueListenable: Hive.box<Place>(hostPlacesTable).listenable(),
                builder: (context, Box<Place> box, child) {

                  if (box.values.isEmpty) {
                    return Center(child: Text('no places'));
                  }

                  return ListView(
                      children: box.values
                          .map((place) => PlaceTile(place: place))
                          .toList());
                })));
  }
}
