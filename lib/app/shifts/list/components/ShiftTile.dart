import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

import '../../edit/Index.dart' as shiftEdit;

class ShiftTile extends StatelessWidget {
  final Place place;
  final Shift shift;

  ShiftTile({@required this.place, @required this.shift})
      : assert(place != null && shift != null);

  @override
  Widget build(BuildContext context) => Column(children: [
        ListTile(
            isThreeLine: true,
            onTap: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext xContext) {
                    return shiftEdit.Index(place: place, shift: shift);
                  });
            },
            leading: CircleAvatar(
                child: Icon(Icons.restaurant_outlined, color: lightGrey),
                backgroundColor: darkGreyFive),
            title: Text(shift.name),
            subtitle: Text(shift.weekDaysAvailable(context) +
                "\n" +
                DateFormat("HH:mm").format(shift.startTime) +
                " - " +
                DateFormat("HH:mm").format(shift.endTime))),
        Divider()
      ]);
}
