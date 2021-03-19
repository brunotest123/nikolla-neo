import 'package:flutter/material.dart';

class WeekDaysTranslate {
  static List<String> list() {
    return [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
  }

  static List<String> translated(BuildContext context,
      {List<String> weekDaysList}) {
    List<String> weekDays = [];

    List<String> available = weekDaysList == null ? list() : weekDaysList;

    if (available.contains(list()[0])) weekDays.add(list()[0]);
    if (available.contains(list()[1])) weekDays.add(list()[1]);
    if (available.contains(list()[2])) weekDays.add(list()[2]);
    if (available.contains(list()[3])) weekDays.add(list()[3]);
    if (available.contains(list()[4])) weekDays.add(list()[4]);
    if (available.contains(list()[5])) weekDays.add(list()[5]);
    if (available.contains(list()[6])) weekDays.add(list()[6]);

    return weekDays;
  }
}
