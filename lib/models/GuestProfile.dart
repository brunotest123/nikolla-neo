import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/clients/Serealizable.dart';

part 'GuestProfile.g.dart';

const String guestProfilesTable = "nikolla_guest_profiles";

@HiveType(typeId: 2)
class GuestProfile extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String email;
  GuestProfile({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
  });

  String fullName() => [this.firstName, this.lastName]
      .where((element) => element != null)
      .join(' ');

  Map<String, dynamic> toMap({bool ignoreId}) {
    Map<String, dynamic> map = Map<String, dynamic>();

    if (this.id != null && ignoreId != true) map['id'] = this.id;
    if (this.firstName != null) map['first_name'] = this.firstName;
    if (this.lastName != null) map['last_name'] = this.lastName;
    if (this.email != null) map['email'] = this.email;

    return map;
  }

  factory GuestProfile.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return GuestProfile(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GuestProfile.fromJson(String source) =>
      GuestProfile.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];
}

class GuestProfileSerializable implements Serializable<GuestProfile> {
  @override
  String record = 'guest_profile';

  @override
  String records = 'guest_profiles';

  @override
  GuestProfile fromJson(Map<String, dynamic> json,
      {Map<String, dynamic> includedJson}) {
    return GuestProfile.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(GuestProfile booking) {
    return booking.toMap();
  }

  @override
  List<GuestProfile> fromJsonArray(List<dynamic> jsonArray) => jsonArray
      ?.map((postMap) => postMap == null ? null : fromJson(postMap))
      ?.toList();

  @override
  List<dynamic> toJsonArray(List<GuestProfile> postList) {
    return postList?.map((post) => post?.toJson())?.toList();
  }
}
