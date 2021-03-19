import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/clients/Serealizable.dart';
import 'package:nikolla_neo/models/Product.dart';
import 'package:nikolla_neo/models/Shift.dart';

part 'Place.g.dart';

const String hostPlacesTable = "host_places";
const String guestPlacesTable = "guest_places";

@HiveType(typeId: 4)
class Place extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;

  @HiveField(3)
  final String addressOne;
  @HiveField(4)
  final String addressTwo;
  @HiveField(5)
  final String postalCode;
  @HiveField(6)
  final String city;
  @HiveField(7)
  final String county;
  @HiveField(8)
  final String country;
  @HiveField(9)
  final List<Product> products;
  @HiveField(10)
  final List<Shift> shifts;
  @HiveField(11)
  final String locale;

  Place(
      {this.id,
      this.name,
      this.description,
      this.addressOne,
      this.addressTwo,
      this.postalCode,
      this.city,
      this.county,
      this.country,
      this.locale,
      this.products,
      this.shifts});

  String addressInfo() => "";

  Map<String, dynamic> toMap({bool ignoreId}) {
    Map<String, dynamic> map = Map<String, dynamic>();

    if (this.id != null && ignoreId != true) map['id'] = this.id;
    if (this.name != null) map['name'] = this.name;
    if (this.description != null) map['description'] = this.description;
    if (this.addressOne != null) map['address_1'] = this.addressOne;
    if (this.addressTwo != null) map['address_2'] = this.addressTwo;
    if (this.postalCode != null) map['postal_code'] = this.postalCode;
    if (this.city != null) map['city'] = this.city;
    if (this.county != null) map['county'] = this.county;
    if (this.country != null) map['country'] = this.country;
    if (this.locale != null) map['locale'] = this.locale;
    if (this.products != null)
      map['products'] = this.products.map((e) => e.toMap()).toList();
    if (this.shifts != null)
      map['shifts'] = this.shifts.map((e) => e.toMap()).toList();

    return map;
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Place(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        addressOne: map['address_1'],
        addressTwo: map['address_2'],
        postalCode: map['postal_code'],
        city: map['city'],
        county: map['county'],
        country: map['country'],
        locale: map['locale'],
        products: ProductSerializable().fromJsonArray(map['products']),
        shifts: ShiftSerializable().fromJsonArray(map['shifts']));
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];
}

class PlaceSerializable implements Serializable<Place> {
  @override
  String record = 'place';

  @override
  String records = 'places';

  @override
  Place fromJson(Map<String, dynamic> json,
          {Map<String, dynamic> includedJson}) =>
      Place.fromMap(json);

  @override
  Map<String, dynamic> toJson(Place entity) => entity.toMap();

  @override
  List<Place> fromJsonArray(List<dynamic> jsonArray) => jsonArray
      ?.map((postMap) => postMap == null ? null : fromJson(postMap))
      ?.toList();

  @override
  List<dynamic> toJsonArray(List<Place> postList) =>
      postList?.map((post) => post?.toJson())?.toList();
}
