import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/app/place/show/components/Options.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class Index extends StatelessWidget {
  final Place place;

  Index({@required this.place}) : assert(place != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(place.name, style: TextStyle(color: darkGrey)),
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
                },
              ),
            )),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<Place>(hostPlacesTable).listenable(),
                  builder: (context, Box<Place> box, child) {
                    Place placeData = box.values
                        .firstWhere((element) => element.id == place.id);

                    return Options(box: box, place: placeData);
                  }))
        ]));
  }
}
