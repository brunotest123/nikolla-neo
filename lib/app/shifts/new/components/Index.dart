import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/shifts/new/components/NameForm.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Index extends StatelessWidget {
  final Place place;

  Index({@required this.place}) : assert(place != null);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: Hive.box<Shift>(draftShiftsTable).listenable(),
      builder: (context, Box<Shift> box, child) {
        if (box.values.isEmpty) return Container();

        Shift shift = box.values.first;

        return NameForm(place: place, shift: shift);
      });
}
