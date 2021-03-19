import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:nikolla_neo/api/clients/Serealizable.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/User.dart';

class Booking extends Equatable {
  final String id;
  final DateTime startAt;
  final DateTime endAt;
  final String kind;
  final int numGuest;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;
  final Place place;

  Booking({
    this.id,
    this.startAt,
    this.endAt,
    this.kind,
    this.numGuest,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.place,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'start_at': startAt,
      'end_at': endAt,
      'kind': kind,
      'num_guest': numGuest,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user?.toMap(),
      'place': place?.toMap(),
    };
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
        status: map['status'],
        createdAt: (map['created_at'] == null
            ? null
            : DateTime.parse(map['created_at'])),
        updatedAt: (map['updated_at'] == null
            ? null
            : DateTime.parse(map['updated_at'])),
        user: User.fromMap(map['user']),
        place: Place.fromMap(map['place']));
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
  String record = 'booking';

  @override
  String records = 'bookings';

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
