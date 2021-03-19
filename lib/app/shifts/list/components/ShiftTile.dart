import 'package:flutter/material.dart';
import 'package:nikolla_neo/models/Shift.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class ShiftTile extends StatelessWidget {
  final Shift shift;

  ShiftTile({@required this.shift}) : assert(shift != null);

  @override
  Widget build(BuildContext context) => Column(children: [
        ListTile(
            leading: CircleAvatar(
                child: Icon(Icons.restaurant_outlined, color: lightGrey),
                backgroundColor: darkGreyFive),
            title: Text(shift.name)),
        Divider()
      ]);
}
