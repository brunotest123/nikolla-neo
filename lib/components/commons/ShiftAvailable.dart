import 'package:flutter/cupertino.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class ShiftAvailable {
  final Place place;
  tz.TZDateTime _currentTZDateTime;

  ShiftAvailable({@required this.place}) : assert(place != null) {
    tz.initializeTimeZones();
    _currentTZDateTime = tz.TZDateTime.now(tz.getLocation(this.place.timeZone));
  }

  List<DateTime> fetch() {
    List<DateTime> results = [];

    this.place.shifts.forEach((shift) {
      results.addAll(_populate(shift: shift));
    });

    return results;
  }

  List<Shift> findShifts({@required DateTime dateSelected}) {
    List<Shift> results = [];

    tz.TZDateTime _tZStartTime = tz.TZDateTime(
        tz.getLocation(place.timeZone),
        dateSelected.year,
        dateSelected.month,
        dateSelected.day,
        dateSelected.hour,
        dateSelected.minute);

    _addDate(Shift s) {
      bool _hasDate = _populate(shift: s)
              .where(
                  (element) => element.difference(_tZStartTime).inMinutes == 0)
              .length !=
          0;

      if (_hasDate) results.add(s);
    }

    this.place.shifts.forEach((s) => _addDate(s));

    return results;
  }

  List<DateTime> _populate({@required Shift shift}) {
    DateTime startTime = tz.TZDateTime(
        tz.getLocation(this.place.timeZone),
        _currentTZDateTime.year,
        _currentTZDateTime.month,
        _currentTZDateTime.day,
        shift.startTime.hour,
        shift.startTime.minute);

    DateTime endTime = tz.TZDateTime(
        tz.getLocation(this.place.timeZone),
        _currentTZDateTime.year,
        _currentTZDateTime.month,
        _currentTZDateTime.day,
        shift.endTime.hour,
        shift.endTime.minute);

    return _generateTimeAvailable(
        startTime: startTime, endTime: endTime, shift: shift);
  }

  List<DateTime> _generateTimeAvailable(
      {@required tz.TZDateTime startTime,
      @required tz.TZDateTime endTime,
      @required Shift shift}) {
    List<DateTime> _results = [];

    int _currentDateTimeDiff = _currentTZDateTime
        .difference(
            startTime.add(Duration(minutes: shift.intervalBetweenBooking * -1)))
        .inMilliseconds;

    if (_currentDateTimeDiff < 0) {
      _results.addAll(_addDaysAvailable(
          startTime: startTime
              .add(Duration(minutes: shift.intervalBetweenBooking * -1)),
          endTime: endTime,
          shift: shift));
    } else {
      _results.addAll(_addDaysAvailable(
          startTime: _checkNextTimeOnTheDay(
              currentDateTime: _currentTZDateTime,
              interval: shift.intervalBetweenBooking),
          endTime: endTime,
          shift: shift));
    }

    if (_currentDateTimeDiff == 0) {}

    for (int i = 1; i < shift.rollingDaysBooking; i++) {
      _results.addAll(_addDaysAvailable(
          startTime: startTime.add(
              Duration(days: i, minutes: shift.intervalBetweenBooking * -1)),
          endTime: endTime.add(Duration(days: i)),
          shift: shift));
    }

    _results.toSet().toList();

    _results.sort((a, b) => a.compareTo(b));

    return _results;
  }

  List<DateTime> _addDaysAvailable(
      {@required tz.TZDateTime startTime,
      @required tz.TZDateTime endTime,
      @required Shift shift}) {
    tz.TZDateTime date = startTime;
    if (shift.weekDaysIds().contains(date.weekday) == false) {
      return [];
    }

    List<DateTime> _results = [];

    if (startTime.difference(endTime).inDays != 0) {
      throw Exception('days between start and end should be the same');
    }

    while (date.difference(endTime).inMinutes < 0) {
      date = _checkNextTimeOnTheDay(
          currentDateTime: date, interval: shift.intervalBetweenBooking);

      _results.add(date);
    }

    return _results;
  }

  tz.TZDateTime _checkNextTimeOnTheDay(
      {@required tz.TZDateTime currentDateTime, @required int interval}) {
    switch (interval) {
      case 15:
        if (currentDateTime.minute >= 0 && currentDateTime.minute < interval) {
          return currentDateTime
              .add(Duration(minutes: (interval - currentDateTime.minute)));
        }

        if (currentDateTime.minute >= 15 && currentDateTime.minute < 30) {
          return currentDateTime
              .add(Duration(minutes: (30 - currentDateTime.minute)));
        }

        if (currentDateTime.minute >= 30 && currentDateTime.minute < 45) {
          return currentDateTime
              .add(Duration(minutes: (45 - currentDateTime.minute)));
        }

        if (currentDateTime.minute >= 45 && currentDateTime.minute < 60) {
          return currentDateTime
              .add(Duration(minutes: (60 - currentDateTime.minute)));
        }
        break;
      case 30:
        if (currentDateTime.minute >= 0 && currentDateTime.minute < interval) {
          return currentDateTime
              .add(Duration(minutes: (30 - currentDateTime.minute)));
        }

        if (currentDateTime.minute >= 30 && currentDateTime.minute < 60) {
          return currentDateTime
              .add(Duration(minutes: (60 - currentDateTime.minute)));
        }
        break;
      default:
        return currentDateTime.add(Duration(minutes: interval));
    }

    return null;
  }
}
