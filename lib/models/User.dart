import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/clients/Serealizable.dart';

part 'User.g.dart';

const String usersTable = "nikolla_users";

@HiveType(typeId: 3)
enum Policy {
  @HiveField(0)
  nikers,
  @HiveField(1)
  testUser
}

const policyString = <Policy, String>{
  Policy.nikers: "nikers",
  Policy.testUser: 'testUser'
};

@HiveType(typeId: 1)
class User extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String countryId;
  @HiveField(2)
  final String mobilePhone;
  @HiveField(3)
  final String internationalNumber;
  @HiveField(4)
  final List<Policy> policies;

  User(
      {this.id,
      this.countryId,
      this.mobilePhone,
      this.internationalNumber,
      this.policies});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    if (this.id != null) map['id'] = this.id;
    if (this.countryId != null) map['country_id'] = this.countryId;
    if (this.mobilePhone != null) map['mobile_phone'] = this.mobilePhone;
    if (this.internationalNumber != null)
      map['international_number'] = this.internationalNumber;
    if (this.policies != null)
      map['policies'] = this.policies.map((e) => policyString[e]);

    return map;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
        id: map['id'],
        countryId: map['country_id'],
        mobilePhone: map['mobile_phone'],
        internationalNumber: map['international_number'],
        policies: (map['policies'] == null
            ? null
            : map['policies']
                .map<Policy>((i) => EnumToString.fromString(Policy.values, i))
                .toList()));
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];
}

class UserSerializable implements Serializable<User> {
  @override
  String record = 'user';

  @override
  String records = 'users';

  @override
  User fromJson(Map<String, dynamic> json,
      {Map<String, dynamic> includedJson}) {
    return User.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(User session) {
    return session.toMap();
  }

  @override
  List<User> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((postMap) => postMap == null ? null : fromJson(postMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<User> postList) {
    return postList?.map((post) => post?.toJson())?.toList();
  }
}
