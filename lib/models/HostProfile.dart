import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/clients/Serealizable.dart';

part 'HostProfile.g.dart';

const String hostProfilesTable = "nikolla_host_profiles";

@HiveType(typeId: 5)
class HostProfile extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String planId;

  HostProfile({this.id, this.name, this.planId});

  Map<String, dynamic> toMap({bool ignoreId}) {
    Map<String, dynamic> map = Map<String, dynamic>();

    if (this.id != null && ignoreId != true) map['id'] = this.id;
    if (this.name != null) map['name'] = this.name;

    return map;
  }

  factory HostProfile.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return HostProfile(id: map['id'], name: map['name']);
  }

  String toJson() => json.encode(toMap());

  factory HostProfile.fromJson(String source) =>
      HostProfile.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
}

class HostProfileSerializable implements Serializable<HostProfile> {
  @override
  String record = 'host_profile';

  @override
  String records = 'host_profiles';

  @override
  HostProfile fromJson(Map<String, dynamic> json,
      {Map<String, dynamic> includedJson}) {
    return HostProfile.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(HostProfile booking) {
    return booking.toMap();
  }

  @override
  List<HostProfile> fromJsonArray(List<dynamic> jsonArray) => jsonArray
      ?.map((postMap) => postMap == null ? null : fromJson(postMap))
      ?.toList();

  @override
  List<dynamic> toJsonArray(List<HostProfile> postList) {
    return postList?.map((post) => post?.toJson())?.toList();
  }
}
