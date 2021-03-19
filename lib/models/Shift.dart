import 'dart:convert';

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

  Shift({
    this.id,
    this.name,
    this.kind = 'table',
    this.startTime,
    this.endTime,
    this.weekDays,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

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
    if (this.createdAt != null) map['created_at'] = this.createdAt.toString();
    if (this.updatedAt != null) map['updated_at'] = this.updatedAt.toString();

    return map;
  }

  factory Shift.fromMap(Map<String, dynamic> map) {
    List<dynamic> weekDaysParsed =
        (map['week_days'] == null ? [] : map['week_days']);

    return Shift(
      id: map['id'],
      name: map['name'],
      kind: map['kind'],
      weekDays: weekDaysParsed.map((i) => i.toString()).toList(),
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
