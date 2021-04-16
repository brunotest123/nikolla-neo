import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/clients/Serealizable.dart';
import 'package:geocoder/geocoder.dart';

part 'Session.g.dart';

const String sessionsTable = "nikolla_sessions";

@HiveType(typeId: 0)
class Session extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String buildVersion;
  @HiveField(2)
  final String salt;
  @HiveField(3)
  final String deviceName;
  @HiveField(4)
  final String deviceModel;
  @HiveField(5)
  final String systemName;
  @HiveField(6)
  final String systemVersion;
  @HiveField(7)
  final String refreshToken;
  @HiveField(8)
  final double lat;
  @HiveField(9)
  final double lng;
  @HiveField(10)
  final String location;
  final String securityToken;

  Session(
      {this.id,
      this.buildVersion,
      this.salt,
      this.deviceName,
      this.deviceModel,
      this.systemName,
      this.systemVersion,
      this.refreshToken,
      this.securityToken,
      this.lat,
      this.location,
      this.lng});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapData = Map<String, dynamic>();

    if (this.id != null) mapData['id'] = this.id;
    if (this.buildVersion != null) mapData['build_version'] = this.buildVersion;
    if (this.salt != null) mapData['salt'] = this.salt;
    if (this.deviceName != null) mapData['device_name'] = this.deviceName;
    if (this.deviceModel != null) mapData['device_model'] = this.deviceModel;
    if (this.systemName != null) mapData['system_name'] = this.systemName;
    if (this.systemVersion != null)
      mapData['system_version'] = this.systemVersion;
    if (this.refreshToken != null) mapData['refresh_token'] = this.refreshToken;
    if (this.securityToken != null)
      mapData['security_token'] = this.securityToken;
    if (this.lat != null) mapData['lat'] = this.lat;
    if (this.lng != null) mapData['lng'] = this.lng;
    if (this.location != null) mapData['location'] = this.location;

    return mapData;
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Session(
        id: map['id'],
        buildVersion: map['build_version'],
        salt: map['salt'],
        deviceName: map['device_name'],
        deviceModel: map['device_model'],
        systemName: map['system_name'],
        systemVersion: map['system_version'],
        securityToken: (map['security_token'] != null
            ? map['security_token'].toString()
            : null),
        refreshToken: map['refresh_token'],
        location: map['location'],
        lat: (map['lat'] is String ? double.parse(map['lat']) : map['lat']),
        lng: (map['lng'] is String ? double.parse(map['lng']) : map['lng']));
  }

  Future<String> findLocation() async {
    if (lat == null || lng == null) return "";

    // TODO: add try catch to avoid error when the connection is offline.
    List<Address> addresses = await Geocoder.local
        .findAddressesFromCoordinates(Coordinates(lat, lng));

    if (addresses.length == 0) return "";

    Address address = addresses.first;

    return [
      (address.subLocality == "" ? address.locality : address.subLocality),
      (address.subLocality == "" ? address.countryName : address.locality)
    ].where((element) => element != null).join(', ');
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];
}

class SessionSerializable implements Serializable<Session> {
  @override
  String record = 'session';

  @override
  String records = 'sessions';

  @override
  Session fromJson(Map<String, dynamic> json,
      {Map<String, dynamic> includedJson}) {
    return Session.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(Session session) {
    return session.toMap();
  }

  @override
  List<Session> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((postMap) => postMap == null ? null : fromJson(postMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<Session> postList) {
    return postList?.map((post) => post?.toJson())?.toList();
  }
}
