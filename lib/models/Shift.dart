import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/clients/Serealizable.dart';
import 'package:nikolla_neo/components/commons/WeekDaysTransale.dart';

part 'Shift.g.dart';

@HiveType(typeId: 8)
enum ShiftStatus {
  @HiveField(0)
  maintenance,
  @HiveField(1)
  online
}

const shiftStatusString = <ShiftStatus, String>{
  ShiftStatus.maintenance: "maintenance",
  ShiftStatus.online: 'online'
};

const String draftShiftsTable = "draft_shifts";

@HiveType(typeId: 10)
class Shift extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final DateTime startTime;
  @HiveField(3)
  final DateTime endTime;
  @HiveField(4)
  final List<String> weekDays;
  @HiveField(5)
  final String kind;
  @HiveField(6)
  final ShiftStatus status;
  @HiveField(7)
  final DateTime createdAt;
  @HiveField(8)
  final DateTime updatedAt;
  @HiveField(9)
  final int intervalBetweenBooking;
  @HiveField(10)
  final int rollingDaysBooking;
  @HiveField(11)
  final int maxNumberOfGuests;

  Shift(
      {this.id,
      this.name,
      this.kind = 'table',
      this.startTime,
      this.endTime,
      this.weekDays,
      this.status,
      this.intervalBetweenBooking,
      this.rollingDaysBooking,
      this.createdAt,
      this.updatedAt,
      this.maxNumberOfGuests});

  List<int> weekDaysIds() {
    List<int> results = [];
    if (weekDays.contains('Monday')) results.add(1);
    if (weekDays.contains('Tuesday')) results.add(2);
    if (weekDays.contains('Wednesday')) results.add(3);
    if (weekDays.contains('Thursday')) results.add(4);
    if (weekDays.contains('Friday')) results.add(5);
    if (weekDays.contains('Saturday')) results.add(6);
    if (weekDays.contains('Sunday')) results.add(7);

    return results;
  }

  String weekDaysAvailable(BuildContext context) =>
      (this.weekDays == null || this.weekDays.length == 0
          ? "No available"
          : WeekDaysTranslate.translated(context, weekDaysList: this.weekDays)
              .join(', '));

  Map<String, dynamic> toMap({bool ignoreId}) {
    Map<String, dynamic> map = Map<String, dynamic>();

    if (this.id != null && ignoreId != true) map['id'] = this.id;
    if (this.name != null) map['name'] = this.name;
    if (this.kind != null) map['kind'] = this.kind;
    if (this.startTime != null) map['start_time'] = this.startTime.toString();
    if (this.endTime != null) map['end_time'] = this.endTime.toString();
    if (this.weekDays != null) map['week_days'] = this.weekDays.toList();
    if (this.status != null) map['status'] = shiftStatusString[this.status];
    if (this.intervalBetweenBooking != null)
      map['interval_between_booking'] = this.intervalBetweenBooking;
    if (this.rollingDaysBooking != null)
      map['rolling_days_booking'] = this.rollingDaysBooking;
    if (this.maxNumberOfGuests != null)
      map['max_number_of_guests'] = this.maxNumberOfGuests;
    if (this.createdAt != null) map['created_at'] = this.createdAt.toString();
    if (this.updatedAt != null) map['updated_at'] = this.updatedAt.toString();

    return map;
  }

  factory Shift.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    List<dynamic> weekDaysParsed =
        (map['week_days'] == null ? [] : map['week_days']);

    return Shift(
      id: map['id'],
      name: map['name'],
      kind: map['kind'],
      intervalBetweenBooking: map['interval_between_booking'],
      rollingDaysBooking: map['rolling_days_booking'],
      maxNumberOfGuests: map['max_number_of_guests'],
      weekDays: weekDaysParsed.map((i) => i.toString()).toList(),
      status: EnumToString.fromString(ShiftStatus.values, map['status']),
      startTime: (map['start_time'] == null
          ? null
          : DateTime.parse(map['start_time'])),
      endTime:
          (map['end_time'] == null ? null : DateTime.parse(map['end_time'])),
      createdAt: (map['created_at'] == null
          ? null
          : DateTime.parse(map['created_at'])),
      updatedAt: (map['updated_at'] == null
          ? null
          : DateTime.parse(map['updated_at'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory Shift.fromJson(String source) => Shift.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];
}

class ShiftSerializable implements Serializable<Shift> {
  @override
  String record = 'shift';

  @override
  String records = 'shifts';

  @override
  Shift fromJson(Map<String, dynamic> json,
          {Map<String, dynamic> includedJson}) =>
      Shift.fromMap(json);

  @override
  Map<String, dynamic> toJson(Shift entity) => entity.toMap();

  @override
  List<Shift> fromJsonArray(List<dynamic> jsonArray) => (jsonArray == null
      ? []
      : jsonArray
          ?.map((postMap) => postMap == null ? null : fromJson(postMap))
          ?.toList());

  @override
  List<dynamic> toJsonArray(List<Shift> postList) =>
      postList?.map((post) => post?.toJson())?.toList();
}
