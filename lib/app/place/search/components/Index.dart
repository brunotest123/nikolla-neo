import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/app/place/search/components/NotFound.dart';
import 'package:nikolla_neo/models/Place.dart';
// import 'package:nikolla_neo/app/place/search/components/NotFound.dart';
// import 'package:nikolla_neo/app/place/search/components/PlaceItem.dart';
// import 'package:nikolla_neo/app/place/search/components/PlaceList.dart';
// import 'package:nikolla_neo/styleguide/colors.dart';

class Index extends StatelessWidget {
  final ValueNotifier<bool> arrowNotification;
  final ValueNotifier<bool> fetchPlacesNotification;

  Index({@required this.arrowNotification, this.fetchPlacesNotification})
      : assert(arrowNotification != null);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: arrowNotification,
      builder: (context, value, child) {
        if (value == false) {
          return Expanded(
              child: Container(
                  color: Colors.white,
                  child: ValueListenableBuilder(
                      valueListenable:
                          Hive.box<Place>(guestPlacesTable).listenable(),
                      builder: (context, Box<Place> box, child) {
                        if (box.values.isEmpty == true) {
                          return NotFound();
                        }

                        return Container();
                      })
                  // ScreenContainer(top: 40, child: NotFound())
                  // Expanded(child: PlaceList(places: [])),

                  ));
        }

        return Container();
      });
}
