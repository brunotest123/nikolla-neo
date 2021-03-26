import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/clients/Serealizable.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';
import 'package:nikolla_neo/models/User.dart';

part 'Booking.g.dart';

const String guestBookingsTable = "nikolla_guest_bookings";
const String hostBookingsTable = "host_bookings";

@HiveType(typeId: 11)
class Booking extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final DateTime startAt;
  @HiveField(2)
  final DateTime endAt;
  @HiveField(3)
  final String kind;
  @HiveField(4)
  final int numGuest;
  @HiveField(5)
  final String status;
  @HiveField(6)
  final DateTime createdAt;
  @HiveField(7)
  final DateTime updatedAt;
  @HiveField(8)
  final User user;
  @HiveField(9)
  final Place place;
  @HiveField(10)
  final Shift shift;
  @HiveField(11)
  final int numOfTable;

  Booking(
      {this.id,
      this.startAt,
      this.endAt,
      this.kind,
      this.numGuest,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.place,
      this.shift,
      this.numOfTable});

  Map<String, dynamic> toMap({bool ignoreId}) {
    Map<String, dynamic> map = Map<String, dynamic>();

    if (this.id != null && ignoreId != true) map['id'] = this.id;
    if (this.startAt != null) map['start_at'] = this.startAt.toString();
    if (this.endAt != null) map['end_at'] = this.endAt.toString();
    if (this.kind != null) map['kind'] = this.kind.toString();
    if (this.numGuest != null) map['num_guest'] = this.numGuest;
    if (this.numOfTable != null) map['num_of_table'] = this.numOfTable;
    if (this.status != null) map['status'] = this.status;
    if (this.createdAt != null) map['created_at'] = this.createdAt.toString();
    if (this.updatedAt != null) map['updated_at'] = this.updatedAt.toString();
    if (this.user != null && ignoreId != true) map['user'] = this.user.toMap();
    if (this.shift != null && ignoreId != true)
      map['shift'] = this.shift.toMap();
    if (this.place != null && ignoreId != true)
      map['place'] = this.place.toMap();

    return map;
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Booking(
        id: map['id'],
        startAt:
            (map['start_at'] == null ? null : DateTime.parse(map['start_at'])),
        endAt: (map['end_at'] == null ? null : DateTime.parse(map['end_at'])),
        kind: map['kind'],
        numGuest: map['num_guest']?.toInt(),
        numOfTable: map['num_of_table'],
        status: map['status'],
        createdAt: (map['created_at'] == null
            ? null
            : DateTime.parse(map['created_at'])),
        updatedAt: (map['updated_at'] == null
            ? null
            : DateTime.parse(map['updated_at'])),
        user: User.fromMap(map['user']),
        place: Place.fromMap(map['place']),
        shift: Shift.fromMap(map['shift']));
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [id];
  }
}

class BookingSerializable implements Serializable<Booking> {
  @override
  String record = 'orders/booking';

  @override
  String records = 'orders/bookings';

  @override
  Booking fromJson(Map<String, dynamic> json,
      {Map<String, dynamic> includedJson}) {
    return Booking.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(Booking booking) {
    return booking.toMap();
  }

  @override
  List<Booking> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((postMap) => postMap == null ? null : fromJson(postMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<Booking> postList) {
    return postList?.map((post) => post?.toJson())?.toList();
  }
}
