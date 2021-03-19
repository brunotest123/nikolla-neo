import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/shifts/list/components/ShiftTile.dart';
import 'package:nikolla_neo/app/shifts/list/controllers/FetchShiftsController.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

import '../../new/components/Index.dart' as shiftNew;

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Index extends StatelessWidget {
  final Place place;

  Index({@required this.place}) : assert(place != null) {
    FetchShiftsController(place: this.place).call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Shifts", style: TextStyle(color: darkGrey)),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: ValueListenableBuilder(
                      valueListenable:
                          Hive.box<Shift>(draftShiftsTable).listenable(),
                      builder: (context, Box<Shift> box, child) {
                        if (box.values.isEmpty) {
                          return Container();
                        }

                        return InkWell(
                          child: Icon(Icons.plus_one, color: links),
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) {
                                  return shiftNew.Index(place: place);
                                });
                          },
                        );
                      }))
            ],
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
                    return Center(child: Text('no place'));
                  }

                  Place response =
                      box.values.firstWhere((element) => element == place);

                  return ListView(
                      children: response.shifts
                          .map((shift) => ShiftTile(shift: shift))
                          .toList());
                })));
  }
}
